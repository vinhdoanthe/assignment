# frozen_string_literal: true

class SubmissionGrade < ApplicationRecord
  extend Enumerize
  include Constants

  belongs_to :assignment
  belongs_to :student, class_name: 'User', foreign_key: 'student_id'
  belongs_to :mentor, class_name: 'User', foreign_key: 'mentor_id', optional: true
  has_one_attached :submission_file
  has_one_attached :graded_file
  has_one :graded_rubric
  has_many :graded_criteriums, through: :graded_rubric

  has_paper_trail on: %i[create update destroy]

  accepts_nested_attributes_for :graded_rubric

  enumerize :status, in: [Constants::SUBMISSION_GRADE_STATUS_SUBMITTED,
                                     Constants::SUBMISSION_GRADE_STATUS_ASSIGNED,
                                     Constants::SUBMISSION_GRADE_STATUS_PASSED,
                                     Constants::SUBMISSION_GRADE_STATUS_NOTPASSED]

  def self.update_latest(student_id, assignment_id, attempt)
    begin
      prev_latest = SubmissionGrade.where(student_id: student_id, assignment_id: assignment_id, attempt_count: attempt).first
    rescue StandardError
      prev_latest = nil
    end
    unless prev_latest.nil?
      prev_latest.latest = false
      begin
        unless prev_latest.save
        end
      rescue DBMError
        flash[:notice] = DBMError.to_s
      end
    end
  end

  def self.create_graded_rubric(submission_id)
    submission_grade = SubmissionGrade.find(submission_id)
    rubric = submission_grade.assignment.rubric
    unless rubric.nil?
      passed_criteriums = submission_grade.attempt_count == 1 ? [] : Assignment.get_graded_criteria(submission_grade.assignment_id, submission_grade.student_id)
      passed_indexes = passed_criteriums.empty? ? [] : passed_criteriums.map(&:index)

      graded_rubric = GradedRubric.new(description: rubric.description, rubric_id: rubric.id, rubric_type: rubric.rubric_type, point: 0)
      graded_rubric.submission_grade_id = submission_id

      graded_rubric.save

      begin
        criteria_formats = rubric.criteria_formats

        criteria_formats&.each do |criteria_format|
          if passed_indexes.empty?
            criteria = GradedCriterium.new(index: criteria_format.index,
                                           description: criteria_format.description,
                                           required: criteria_format.required,
                                           weighted: criteria_format.weighted,
                                           is_passed: false,
                                           point: 0)
            criteria.graded_rubric_id = graded_rubric.id
          else
            unless passed_indexes.includes(criteria_format.index)
              criteria = GradedCriterium.new(index: criteria_format.index,
                                             description: criteria_format.description,
                                             required: criteria_format.required,
                                             weighted: criteria_format.weighted,
                                             is_passed: false,
                                             point: 0)
              criteria.graded_rubric_id = graded_rubric.id
            end
          end

          begin
            criteria.save
          rescue StandardError
            puts 'Error when save graded_criteria at create_graded_rubric'
            logger.fatal 'Error when save graded_criteria at create_graded_rubric'
          end
        end
      rescue StandardError
        logger.fatal 'Error when save load criteria formats'
      end

    end
  end
end
