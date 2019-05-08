class User < ApplicationRecord
  include Constants
  extend Enumerize

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable

  has_many :enrollments
  has_many :course_instances, through: :enrollments
  has_many :submission_grades, :foreign_key => :student_id

  def display_name
    "#{username} - #{role}"
  end
  def admin?
    self.role == Constants::USER_ROLE_ADMIN
  end

  def learner?
    self.role == Constants::USER_ROLE_LEARNER
  end

  def mentor?
    self.role == Constants::USER_ROLE_MENTOR
  end

  enumerize :role, in: [Constants::USER_ROLE_ADMIN, Constants::USER_ROLE_MENTOR, Constants::USER_ROLE_LEARNER]
  enumerize :status, in: [Constants::USER_STATUS_ACTIVE, Constants::USER_STATUS_INACTIVE]
  class << self
    def get_roles
      {
          Constants::USER_ROLE_ADMIN => Constants::USER_ROLE_ADMIN,
          Constants::USER_ROLE_MENTOR => Constants::USER_ROLE_MENTOR,
          Constants::USER_ROLE_LEARNER => Constants::USER_ROLE_LEARNER
      }
    end

    def get_statuses
      {
          Constants::USER_STATUS_ACTIVE => Constants::USER_STATUS_ACTIVE,
          Constants::USER_STATUS_INACTIVE => Constants::USER_STATUS_INACTIVE
      }
    end
  end
end
