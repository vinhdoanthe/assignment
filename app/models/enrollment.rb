# frozen_string_literal: true

class Enrollment < ApplicationRecord
  extend Enumerize
  include Constants

  validates :user_id, uniqueness: { scope: :course_instance_id,
                                    message: 'This enrollment has existed' }
  validates :start_date, presence: false
  validates :end_date, presence: false

  belongs_to :user
  belongs_to :course_instance

  enumerize :status, in: [Constants::ENROLLMENT_STATUS_UNENROLL,
                          Constants::ENROLLMENT_STATUS_ACTIVE,
                          Constants::ENROLLMENT_STATUS_PENDING,
                          Constants::ENROLLMENT_STATUS_COMPLETED,
                          Constants::ENROLLMENT_STATUS_STOPPED]
end
