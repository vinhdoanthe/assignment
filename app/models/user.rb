class User < ApplicationRecord
  include Constants
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :enrollments
  has_many :course_instances, through: :enrollments
  has_many :submission_grades, :foreign_key => :student_id

  def admin?
    self.role == Constants::USER_ROLE_ADMIN
  end

  def learner?
    self.role == Constants::USER_ROLE_LEARNER
  end

  def mentor?
    self.role == Constants::USER_ROLE_MENTOR
  end

  class << self
    def get_roles
      roles = {
          Constants::USER_ROLE_ADMIN => Constants::USER_ROLE_ADMIN,
          Constants::USER_ROLE_MENTOR => Constants::USER_ROLE_MENTOR,
          Constants::USER_ROLE_LEARNER => Constants::USER_ROLE_LEARNER
      }
    end

    def get_statuses
      statuses = {
          'active' => 'active',
          'inactive' => 'inactive'
      }
    end
  end
end
