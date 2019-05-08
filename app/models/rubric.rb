# frozen_string_literal: true

class Rubric < ApplicationRecord
  extend Enumerize
  include Constants

  belongs_to :assignment
  has_many :criteria_formats, dependent: :destroy, inverse_of: :rubric

  accepts_nested_attributes_for :criteria_formats, allow_destroy: true

  enumerize :status, in: [Constants::RUBRIC_STATUS_ACTIVE, Constants::RUBRIC_STATUS_INACTIVE]

  def display_name
    assignment.nil? ? '' : assignment.display_name
  end

end
