class CourseInstance < ApplicationRecord
  belongs_to :program
  belongs_to :course
  has_many :assignments
  validate :validate_constraints

  class << self
    def course_instance_status
      statuses = {
          'developing' => 'developing',
          'active' => 'active',
          'inactive' => 'inactive'
      }
    end
  end

  private

  def validate_constraints
    if start_date > end_date
      errors.add(:end_date, 'End date can not be before Start date')
    end
  end

end
