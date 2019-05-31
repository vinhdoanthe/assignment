class Partner < ApplicationRecord

  has_many :course_instances, inverse_of: :partner

  def display_name
    org.to_s
  end
end