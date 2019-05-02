class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course_instance

  validates :user_id, uniqueness: {scope: :course_instance_id, message: "This enrollment has existed"}
end
