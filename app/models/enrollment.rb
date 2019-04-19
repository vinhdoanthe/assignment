class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course_instance
end
