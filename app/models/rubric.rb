# frozen_string_literal: true

class Rubric < ApplicationRecord
  extend Enumerize
  include Constants

  belongs_to :assignment
  has_many :criteria_formats, inverse_of: :rubric

  enumerize :status, in: [Constants::RUBRIC_STATUS_ACTIVE, Constants::RUBRIC_STATUS_INACTIVE]

  def display_name
    assignment.nil? ? '' : assignment.display_name
  end

  class << self
    def statuses
      {
        Constants::RUBRIC_STATUS_ACTIVE => Constants::RUBRIC_STATUS_ACTIVE,
        Constants::RUBRIC_STATUS_INACTIVE => Constants::RUBRIC_STATUS_INACTIVE
      }
    end
  end
end
