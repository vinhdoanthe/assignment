# frozen_string_literal: true

class SubmissionGrade < ApplicationRecord
  acts_as_paranoid
  extend Enumerize
  include Constants

  belongs_to :assignment, -> {with_deleted}
  belongs_to :student, class_name: 'User', foreign_key: 'student_id'
  belongs_to :mentor, class_name: 'User', foreign_key: 'mentor_id', optional: true
  has_one_attached :submission_file
  has_one_attached :graded_file

  has_one :course_instance, through: :assignment
  has_one :graded_rubric, dependent: :destroy

  has_many :graded_criteriums, through: :graded_rubric

  has_paper_trail on: %i[create update destroy]

  accepts_nested_attributes_for :graded_rubric

  enumerize :status, in: [Constants::SUBMISSION_GRADE_STATUS_SUBMITTED,
                          Constants::SUBMISSION_GRADE_STATUS_ASSIGNED,
                          Constants::SUBMISSION_GRADE_STATUS_TAKEN_BACK,
                          Constants::SUBMISSION_GRADE_STATUS_PASSED,
                          Constants::SUBMISSION_GRADE_STATUS_NOT_PASSED]


  validates :submission_file, size: {less_than: 30.megabytes,
                                     message: 'file size is more than 30 MB'}
  # validate :validate_submission_file, on: :create

  def display_name
    "#{assignment.display_name} - Attempt #{attempt}"
  end

  scope :filtered_by_mentor_id, lambda {|mentor_id|
    where(mentor_id: mentor_id)
  }

  scope :sorted_by, lambda {|sort_option|
    direction = /desc$/.match?(sort_option) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^assigned_at_/
      order("submission_grades.assigned_at #{direction}")
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :with_status, lambda {|status|
    where(status: [*status])
  }

  def self.options_for_sorted_by
    [
        [I18n.t('assignment.submission_grade.list.assigned_date_newest_first'), 'assigned_at_desc'],
        [I18n.t('assignment.submission_grade.list.assigned_date_oldest_first'), 'assigned_at_asc']
    ]
  end

  def self.options_for_status
    {
        Constants::SUBMISSION_GRADE_STATUS_ASSIGNED => Constants::SUBMISSION_GRADE_STATUS_ASSIGNED,
        Constants::SUBMISSION_GRADE_STATUS_PASSED => Constants::SUBMISSION_GRADE_STATUS_PASSED,
        Constants::SUBMISSION_GRADE_STATUS_NOT_PASSED => Constants::SUBMISSION_GRADE_STATUS_NOT_PASSED
    }
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

  def self.take_back
    to_taken_submissions = where('status = ? AND is_latest = ? AND assigned_at < ?',
                                 Constants::SUBMISSION_GRADE_STATUS_ASSIGNED,
                                 true,
                                 Time.now - Settings[:submission][:taken_back_after])

    to_taken_submissions.each do |submission|
      SubmissionGradeMailer.taken_back_email(submission.mentor_id, submission).deliver_later
      submission.update(status: Constants::SUBMISSION_GRADE_STATUS_TAKEN_BACK,
                        mentor_id: nil)
      # TODO
    end
  end

  def list_failed_criteria
    list_str = ''
    graded_criteriums.each do |criterium|
      if criterium.get_status == Constants::GRADED_CRITERIA_STATUS_FAILED
        list_str = list_str + ' ' + criterium.index.to_s + ','
      end
    end
    list_str
  end

end
