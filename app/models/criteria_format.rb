class CriteriaFormat < ApplicationRecord
  acts_as_paranoid
  extend Enumerize
  include Constants
  self.table_name = 'criteria_formats'
  belongs_to :rubric

  # validates :index, presence: true,
  #                   uniqueness: {scope: :rubric_id,
  #                                message: 'Criteria index already existed'}

  enumerize :criteria_type, in: [Constants::CRITERIA_TYPE_POINT, Constants::CRITERIA_TYPE_PASS_FAIL]

  def display_name
    if !rubric.nil?
      "#{rubric.display_name} - Criteria #{index}"
    else
      ''
    end
  end
end
