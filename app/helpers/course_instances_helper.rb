module CourseInstancesHelper
  include Constants

  def validate_access_list_assignments_by_course?(course_instance_id)
    begin
      requested_course_instance = CourseInstance.find(course_instance_id)
    rescue
      requested_course_instance = nil
    end
    if requested_course_instance.nil?
      false
    else
      logged_user_active_enrollment_instances = current_user.course_instances
      if logged_user_active_enrollment_instances.nil?
        false
      else
        logged_user_active_enrollment_instances = logged_user_active_enrollment_instances.select {|instance| instance.status == Constants::COURSE_INSTANCE_STATUS_ACTIVE}
        logged_user_active_enrollment_instances.include?(requested_course_instance)
      end
    end
  end
end
