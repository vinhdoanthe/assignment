class User < ApplicationRecord
  extend Enumerize
  include Constants

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :registerable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_many :enrollments
  has_many :course_instances, through: :enrollments
  has_many :submission_grades, foreign_key: :student_id

  def display_name
    "#{username} - #{role}"
  end

  def admin?
    role == Constants::USER_ROLE_ADMIN
  end

  def learner?
    role == Constants::USER_ROLE_LEARNER
  end

  def mentor?
    role == Constants::USER_ROLE_MENTOR
  end

  enumerize :role, in: [Constants::USER_ROLE_ADMIN, Constants::USER_ROLE_MENTOR, Constants::USER_ROLE_LEARNER]
  enumerize :status, in: [Constants::USER_STATUS_ACTIVE, Constants::USER_STATUS_INACTIVE]

end
