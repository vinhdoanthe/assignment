class Rubric < ApplicationRecord
  belongs_to :assignment

  class << self
    def rubric_statuses
      statuses = {
          'active' => 'active',
          'inactive' => 'inactive'
      }
    end
  end
end
