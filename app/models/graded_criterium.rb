# frozen_string_literal: true

class GradedCriterium < ApplicationRecord
  extend Enumerize
  include Constants

  belongs_to :graded_rubric

  # validates :comment, presence: true
  # validates :status, inclusion: { in: [Constants::GRADED_CRITERIA_STATUS_PASSED,
  #                                      Constants::GRADED_CRITERIA_STATUS_FAILED],
  #                                 message: "Status must be #{Constants::GRADED_CRITERIA_STATUS_PASSED} or #{Constants::GRADED_CRITERIA_STATUS_FAILED}" },
  #                    on: :update

  attribute :status, default: Constants::GRADED_CRITERIA_STATUS_NOTGRADED
  attribute :comment, default: ''

  before_save :update_status

  enumerize :status, in: [Constants::GRADED_CRITERIA_STATUS_NOTGRADED,
                          Constants::GRADED_CRITERIA_STATUS_PASSED,
                          Constants::GRADED_CRITERIA_STATUS_FAILED], skip_validations: lambda {|criterium| criterium.new_record?}

  def display_name
    "#{graded_rubric.display_name} - Criteria #{index}"
  end

  def update_status
    if criteria_type == Constants::CRITERIA_TYPE_POINT
      self.status = if point.zero?
                      Constants::GRADED_CRITERIA_STATUS_FAILED
                    else
                      Constants::GRADED_CRITERIA_STATUS_PASSED
                    end
    else
      if status == Constants::GRADED_CRITERIA_STATUS_NOTGRADED
        status == Constants::GRADED_RUBRIC_STATUS_FAILED
      end
      # Do nothing
    end
  end

  def self.create_from_graded_rubric(graded_rubric_id, index, description, status, comment, is_required, criteria_type, weight, point)
    criterium = new(graded_rubric_id: graded_rubric_id,
                    index: index,
                    description: description,
                    status: status,
                    comment: comment,
                    is_required: is_required,
                    criteria_type: criteria_type,
                    weight: weight,
                    point: point)
    begin
      criterium.save
    rescue StandardError => error
      puts "Graded criterium #{error.inspect}"
    end
  end
end
