# frozen_string_literal: true

class Enrollment < ApplicationRecord
  extend Enumerize
  include Constants
  require 'roo'

  TT_STR = 'TT'
  EMAIL_STR = 'Email'
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

  def self.import_from_file(file)
    spreadsheet = open_spreadsheet(file)

    list_enrollments = read_sheet spreadsheet
    puts "list_enrollments #{list_enrollments.inspect}"
    list_errors = []
    list_enrollments.each do |enrollment_row|
      error = create_enrollment enrollment_row
      unless error.empty?
        list_errors.append error
      end
    end

    puts "list_errors #{list_errors.inspect}"
    list_errors
  end

  def self.read_sheet(spreadsheet)
    list_enrollments = []
    spreadsheet.each(tt: TT_STR, email: EMAIL_STR, course_instances: INSTANCE_STR, role: ROLE_STR) do |hash|
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
    user = User.find_or_create_by(email: enrollment_row[:email], role: enrollment_row[:role])
    if user.errors.full_messages.any?
      error = {tt: enrollment_row[:tt], note: user.errors.full_messages.to_s}
      return error
    end

    list_instances.each do |instance|
      course_instance = CourseInstance.find_by_code(instance.to_s)
      if course_instance.nil?
        tmp_error = {tt: enrollment_row[:tt], note: 'Course instance do not exist: ' + instance.to_s}
        error.append(tmp_error)
      else
        enrollment = Enrollment.find_or_create_by(user: user, course_instance: course_instance)
        if enrollment.errors.full_messages.any?
          tmp_error = {tt: enrollment_row[:tt], note: enrollment.errors.full_messages.to_s}
          error.append(tmp_error)
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
  #
  # def self.create_list_import_errors(list_errors)
  #   # TODO
  # end

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
