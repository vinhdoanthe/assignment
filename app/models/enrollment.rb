class Enrollment < ApplicationRecord
  include Constants
  extend Enumerize

  validates :user_id, uniqueness: {scope: :course_instance_id, message: "This enrollment has existed"}

  belongs_to :user
  belongs_to :course_instance

  enumerize :status, in: [Constants::ENROLLMENT_STATUS_UNENROLL,
                          Constants::ENROLLMENT_STATUS_ACTIVE,
                          Constants::ENROLLMENT_STATUS_PENDING,
                          Constants::ENROLLMENT_STATUS_COMPLETED,
                          Constants::ENROLLMENT_STATUS_STOPPED]

end
