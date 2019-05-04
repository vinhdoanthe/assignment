class CourseInstance < ApplicationRecord
  extend Enumerize
  include Constants

  validate :validate_constraints
  validates :code, presence: true, uniqueness: {case_sensitive: false, message: 'Code can not be duplicated!!!'}
  validates :name, presence: true

  belongs_to :program, :inverse_of => :course_instances
  belongs_to :course, :inverse_of => :course_instances
  has_many :assignments

  enumerize :status, in: [Constants::COURSE_INSTANCE_STATUS_ACTIVE,
                          Constants::COURSE_INSTANCE_STATUS_DEVELOPING,
                          COURSE_INSTANCE_STATUS_INACTIVE]

  def display_name
    "#{code}"
  end

  class << self
    def statuses
      {
          Constants::COURSE_INSTANCE_STATUS_ACTIVE => Constants::COURSE_INSTANCE_STATUS_ACTIVE,
          Constants::COURSE_INSTANCE_STATUS_DEVELOPING => Constants::COURSE_INSTANCE_STATUS_DEVELOPING,
          Constants::COURSE_INSTANCE_STATUS_INACTIVE => Constants::COURSE_INSTANCE_STATUS_INACTIVE
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
