# frozen_string_literal: true

class User < ApplicationRecord
  extend Enumerize
  include Constants

  # Include default devise modules. Others available are:
  devise :database_authenticatable, :rememberable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :enrollments
  has_many :course_instances, through: :enrollments
  has_many :submission_grades, foreign_key: :student_id

  enumerize :role, in: [Constants::USER_ROLE_ADMIN, Constants::USER_ROLE_MENTOR, Constants::USER_ROLE_LEARNER]
  enumerize :status, in: [Constants::USER_STATUS_ACTIVE, Constants::USER_STATUS_INACTIVE]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    user
  end

  def display_name
    "#{email} - #{role}"
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

end
