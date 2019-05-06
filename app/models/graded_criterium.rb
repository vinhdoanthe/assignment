class GradedCriterium < ApplicationRecord
  belongs_to :graded_rubric

  validates :index, presence: true, uniqueness: {scope: :graded_rubric_id, message: 'Criteria already existed'}

  def display_name
    "#{graded_rubric.display_name} - Criteria #{index}"
  end
end
