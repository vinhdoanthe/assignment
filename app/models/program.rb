class Program < ApplicationRecord
  acts_as_paranoid
  extend Enumerize
  include Constants

  validates :code, presence: true, uniqueness: { case_sensitive: false,
                                                 messages: 'Program code could not be duplicated!' }
  validates :name, presence: true

  has_many :course_instances, inverse_of: :program
  enumerize :status, in: [Constants::PROGRAM_STATUS_ACTIVE, Constants::PROGRAM_STATUS_INACTIVE]

  def display_name
    code.to_s
  end
end
