class Rubric < ApplicationRecord
  extend Enumerize
  include Constants

  belongs_to :assignment

  enumerize :status, in: [Constants::RUBRIC_STATUS_ACTIVE, Constants::RUBRIC_STATUS_INACTIVE]
  class << self
    def statuses
      {
          Constants::RUBRIC_STATUS_ACTIVE => Constants::RUBRIC_STATUS_ACTIVE,
          Constants::RUBRIC_STATUS_INACTIVE => Constants::RUBRIC_STATUS_INACTIVE
      }
    end
  end
end
