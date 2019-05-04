class Course < ApplicationRecord
  extend Enumerize
  include Constants

  validates :code, presence: true, uniqueness: {case_sensitive: false, messages: 'Program code could not be duplicated!'}
  validates :name, presence: true

  has_many :course_instances, :inverse_of => :course
  enumerize :status, in: [Constants::COURSE_STATUS_ACTIVE, Constants::COURSE_STATUS_INACTIVE]

  class << self
    def course_status
      {
          Constants::COURSE_STATUS_ACTIVE => Constants::COURSE_STATUS_ACTIVE,
          Constants::COURSE_STATUS_INACTIVE => Constants::COURSE_STATUS_INACTIVE
      }
    end
  end
end
