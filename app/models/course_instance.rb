# frozen_string_literal: true

class CourseInstance < ApplicationRecord
  acts_as_paranoid
  extend Enumerize
  include Constants

  validates :code, presence: true, uniqueness: { case_sensitive: false,
                                                 message: 'courseinstance.code.duplicated' }
  validates :name, presence: true

  belongs_to :program, inverse_of: :course_instances
  belongs_to :course, inverse_of: :course_instances
  belongs_to :partner, inverse_of: :course_instances

  has_many :assignments
  has_many :enrollments

  enumerize :status, in: [Constants::COURSE_INSTANCE_STATUS_ACTIVE,
                          Constants::COURSE_INSTANCE_STATUS_DEVELOPING,
                          COURSE_INSTANCE_STATUS_INACTIVE]

  enumerize :locale, in: [Constants::COURSE_INSTANCE_LOCALE_VI,
                          Constants::COURSE_INSTANCE_LOCALE_EN]
  def display_name
    code.to_s
  end
end
