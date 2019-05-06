class CriteriaFormat < ApplicationRecord
  belongs_to :rubric
  self.table_name = 'criteria_formats'

  validates :index, presence: true, uniqueness: {scope: :rubric_id, message: 'Criteria already existed'}

  def display_name
    "#{rubric.display_name} - Criteria #{index}"
  end
end
