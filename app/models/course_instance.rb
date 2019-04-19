class CourseInstance < ApplicationRecord
  belongs_to :program
  belongs_to :course
end
