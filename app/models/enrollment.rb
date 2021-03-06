# frozen_string_literal: true

class Enrollment < ApplicationRecord
  acts_as_paranoid
  extend Enumerize
  include Constants
  require 'roo'

  TT_STR = 'TT'
  EMAIL_STR = 'Email'
  FULL_NAME_STR = 'Full Name'
  INSTANCE_STR = 'Course Instance'
  ROLE_STR = 'Role'

  validates :user_id, uniqueness: {scope: :course_instance_id,
                                   message: 'This enrollment has existed'}
  validates :start_date, presence: false
  validates :end_date, presence: false

  belongs_to :user
  belongs_to :course_instance

  enumerize :status, in: [Constants::ENROLLMENT_STATUS_UNENROLL,
                          Constants::ENROLLMENT_STATUS_ACTIVE,
                          Constants::ENROLLMENT_STATUS_PENDING,
                          Constants::ENROLLMENT_STATUS_COMPLETED,
                          Constants::ENROLLMENT_STATUS_STOPPED]

  def self.reset_results(file)
    spreadsheet = open_spreadsheet(file)

    list_enrollments_to_reset = read_reset_sheet spreadsheet
    list_errors = []
    list_enrollments_to_reset.each do |enrollment_row|
      error = reset_result enrollment_row
      unless error.empty?
        list_errors.append error
      end
    end

    list_errors
  end

  def self.read_reset_sheet(spreadsheet)
    list_enrollments = []
    last_row = spreadsheet.last_row
    (2..last_row).each do |i|
      hash = {}
      hash[:stt] = spreadsheet.cell('A',i)
      hash[:email] = spreadsheet.cell('B',i)
      hash[:full_name] = spreadsheet.cell('C',i)
      hash[:course_instances] = spreadsheet.cell('D',i)
      list_enrollments.append hash
    end
    list_enrollments
  end

  def self.reset_result(enrollment_row)
    user = User.find_by_email(enrollment_row[:email])
    return [] if user.nil?

    list_instances = enrollment_row[:course_instances].to_s.split(',')
    list_instances = list_instances.map(&:strip)
    instance_ids = CourseInstance.where(code: list_instances).pluck(:id)
    return [] if instance_ids.blank?

    assignment_ids = Assignment.where(course_instance_id: instance_ids).pluck(:id)
    return [] if assignment_ids.blank?

    assignment_ids.each do |assignment_id|
      next if is_passed(user.id, assignment_id)
      # Student not passed this assignment
      delete_submissions(user.id, assignment_id)
    end
    []
  end

  def self.is_passed(user_id, assignment_id)
    submissions = SubmissionGrade.where(student_id: user_id, assignment_id: assignment_id).pluck(:status)
    if submissions.include?(Constants::SUBMISSION_GRADE_STATUS_PASSED)
      true
    else
      false
    end
  end

  def self.delete_submissions(user_id, assignment_id)
    submission_ids = SubmissionGrade.where(student_id: user_id, assignment_id: assignment_id).pluck(:id)
    SubmissionGrade.delete(submission_ids) 
  end

  def self.import_from_file(file)
    spreadsheet = open_spreadsheet(file)

    list_enrollments = read_sheet spreadsheet
    list_errors = []
    list_enrollments.each do |enrollment_row|
      error = create_enrollment enrollment_row
      unless error.empty?
        list_errors.append error
      end
    end

    list_errors
  end

  def self.read_sheet(spreadsheet)
    list_enrollments = []
    spreadsheet.each(tt: TT_STR, email: EMAIL_STR, full_name: FULL_NAME_STR,
                     course_instances: INSTANCE_STR, role: ROLE_STR) do |hash|
      list_enrollments.append hash
    end
    list_enrollments.shift
    list_enrollments
  end

  # @param enrollment_row is a row of enrollment file use to import
  # @return nil if create enrollment success else return enrollment_row[:tt] of row if has error when create
  def self.create_enrollment(enrollment_row)
    error = []
    list_instances = enrollment_row[:course_instances].to_s.split(',')
    list_instances = list_instances.map(&:strip)

    # find or create user
    user = User.find_or_create_by(email: enrollment_row[:email])
    if user.errors.full_messages.any?
      error = {tt: enrollment_row[:tt], note: user.errors.full_messages.to_s}
      return error
    else
      if user.update(role: enrollment_row[:role], full_name: enrollment_row[:full_name])
      else
        tmp_error = 'Update user failed' + user.email
        error.append(tmp_error)
      end
    end

    list_instances.each do |instance|
      course_instance = CourseInstance.find_by_code(instance.to_s)
      if course_instance.nil?
        tmp_error = {tt: enrollment_row[:tt], note: 'Course instance do not exist: ' + instance.to_s}
        error.append(tmp_error)
      else
        enrollment = Enrollment.where(user_id: user.id, course_instance_id: course_instance.id).first
        if enrollment.nil?
          enrollment = Enrollment.where(user_id: user.id, course_instance_id: course_instance.id).with_deleted.first
          if enrollment.nil?
            enrollment = Enrollment.new(user_id: user.id, course_instance_id: course_instance.id)
          else
            enrollment.restore
          end
          enrollment.save
          if enrollment.errors.full_messages.any?
            tmp_error = {tt: enrollment_row[:tt], note: enrollment.errors.full_messages.to_s}
            error.append(tmp_error)
          end
        end

        if enrollment.update(status: Constants::ENROLLMENT_STATUS_ACTIVE)
        else
          tmp_error = {tt: enrollment_row[:tt], note: 'Update enrollment status to active failed: ' + instance.to_s}
          error.append(tmp_error)
        end
      end
    end

    error
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then
      Roo::CSV.new(file.path)
    when '.xls' then
      Roo::Excel.new(file.path)
    when '.xlsx' then
      Roo::Excelx.new(file.path)
    else
      raise "Unknown file type: #{file.original_filename}"
    end
  end
end
