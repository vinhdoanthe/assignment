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

  def grade_type=(grade_type)
    # Do nothing
  end

  def grade_type
    assignment.grade_type
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

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: %i[
      sorted_by
      search_query
      with_status
      with_created_at_gte
    ]
  )

  scope :sorted_by, lambda { |sort_option|
    direction = /desc$/.match?(sort_option) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("submission_grades.created_at #{direction}")
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :search_query, lambda { |query|
  }

  scope :with_status, lambda { |status|
    where(status: [*status])
  }

  scope :with_created_at_gte, lambda { |ref_date|
  }

  def self.options_for_sorted_by
    [
      ['Submitted date (newest first)', 'created_at_desc'],
      ['Submitted date (oldest first)', 'created_at_asc']
    ]
  end

  def self.options_for_select
    { Constants::SUBMISSION_GRADE_STATUS_SUBMITTED => Constants::SUBMISSION_GRADE_STATUS_SUBMITTED,
      Constants::SUBMISSION_GRADE_STATUS_ASSIGNED => Constants::SUBMISSION_GRADE_STATUS_ASSIGNED,
      Constants::SUBMISSION_GRADE_STATUS_PASSED => Constants::SUBMISSION_GRADE_STATUS_PASSED,
      Constants::SUBMISSION_GRADE_STATUS_NOTPASSED => Constants::SUBMISSION_GRADE_STATUS_NOTPASSED }
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
