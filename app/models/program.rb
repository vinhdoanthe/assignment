class Program < ApplicationRecord
  class << self
    def program_status
      statuses = {
          'active' => 'active',
          'inactive' => 'inactive'
      }
    end
  end
end
