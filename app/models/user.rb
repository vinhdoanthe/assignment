class User < ApplicationRecord
  extend Enumerize
  include Constants

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :registerable and :omniauthable
  # devise :database_authenticatable,
  #        :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :rememberable
  devise :omniauthable, omniauth_providers: [:google_oauth2]
         # devise: :omniauthable, :omniauthable, omniauth_providers => [:google_oauth2]
  # attr_accessible :email, :password, :password_confirmation,
  #                 :remember_me
  has_many :enrollments
  has_many :course_instances, through: :enrollments
  has_many :submission_grades, foreign_key: :student_id

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first
    # unless user
    #   password = Devise.friendly_token[0, 20]
    #   user = User.create(email: data["email"],
    #                      password: password, password_confirmation: password
    #   )
    # end
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

  enumerize :role, in: [Constants::USER_ROLE_ADMIN, Constants::USER_ROLE_MENTOR, Constants::USER_ROLE_LEARNER]
  enumerize :status, in: [Constants::USER_STATUS_ACTIVE, Constants::USER_STATUS_INACTIVE]

end
