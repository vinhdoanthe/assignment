# frozen_string_literal: true

class SubmissionGrade < ApplicationRecord
  extend Enumerize
  include Constants

  belongs_to :assignment
  belongs_to :student, class_name: 'User', foreign_key: 'student_id'
  belongs_to :mentor, class_name: 'User', foreign_key: 'mentor_id', optional: true
  has_one_attached :submission_file
  has_one_attached :graded_file

  has_one :graded_rubric, dependent: :destroy

  has_many :graded_criteriums, through: :graded_rubric

  has_paper_trail on: %i[create update destroy]

  accepts_nested_attributes_for :graded_rubric

  enumerize :status, in: [Constants::SUBMISSION_GRADE_STATUS_SUBMITTED,
                          Constants::SUBMISSION_GRADE_STATUS_ASSIGNED,
                          Constants::SUBMISSION_GRADE_STATUS_PASSED,
                          Constants::SUBMISSION_GRADE_STATUS_NOTPASSED]

  def display_name
    "#{assignment.display_name} - Attempt #{attempt}"
  end

  def self.update_latest(student_id, assignment_id, attempt)
    begin
      prev_latest = SubmissionGrade.where(student_id: student_id,
                                          assignment_id: assignment_id,
                                          attempt: attempt).first
    rescue StandardError
      prev_latest = nil
    end
    unless prev_latest.nil?
      prev_latest.is_latest = false
      begin
        prev_latest.save
      rescue StandardError => error
        puts "Submission grade update_latest #{error.inspect}"
      end
    end
  end

  def self.create_graded_rubric(submission_id)
    submission_grade = SubmissionGrade.find(submission_id)
    rubric = submission_grade.assignment.rubric
    unless rubric.nil?
      passed_criteriums = submission_grade.attempt == 1 ? [] : Assignment.get_passed_criteria(submission_grade.assignment_id, submission_grade.student_id)
      passed_indexes = passed_criteriums.empty? ? [] : passed_criteriums.map(&:index)

      graded_rubric = GradedRubric.new(comment: '', point: 0)
      graded_rubric.submission_grade_id = submission_id

      graded_rubric.save

      puts "Passed criteriums #{passed_criteriums.inspect}"
      puts "passed_indexes.inspect #{passed_indexes.inspect}"
      puts "graded_rubric.inspect #{graded_rubric.inspect}"

      begin
        criteria_formats = rubric.criteria_formats

        criteria_formats.each do |criteria_format|
          if passed_indexes.empty?
            GradedCriterium.create_from_graded_rubric(graded_rubric.id,
                                                      criteria_format.index,
                                                      criteria_format.description,
                                                      Constants::GRADED_CRITERIA_STATUS_NOTGRADED,
                                                      '',
                                                      criteria_format.is_required,
                                                      criteria_format.criteria_type,
                                                      criteria_format.weight,
                                                      0)
          else
            unless passed_indexes.include?(criteria_format.index)
              GradedCriterium.create_from_graded_rubric(graded_rubric.id,
                                                        criteria_format.index,
                                                        criteria_format.description,
                                                        Constants::GRADED_CRITERIA_STATUS_NOTGRADED,
                                                        '',
                                                        criteria_format.is_required,
                                                        criteria_format.criteria_type,
                                                        criteria_format.weight,
                                                        0)
            end
          end
        end
      rescue StandardError => error
        logger.fatal error.inspect
      end
    end
  end

  def update_point(added_point)

    # Todo find prev attempt and re-calculate point

    if attempt == 1
      self.point = added_point
    else
      prev = SubmissionGrade.where(student_id: student_id,
                                   assignment_id: assignment_id,
                                   attempt: attempt - 1).first
      self.point = prev.point + added_point
    end
  end
end
