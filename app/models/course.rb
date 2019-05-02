class Course < ApplicationRecord

  class << self
    def course_status
      statuses = {
          'active' => 'active',
          'inactive' => 'inactive'
      }
    end
  end
end
