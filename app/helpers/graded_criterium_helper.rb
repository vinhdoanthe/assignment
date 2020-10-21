module GradedCriteriumHelper
  def cr_status_css_class cr_type, cr_status, cr_point
    if cr_type == Constants::CRITERIA_TYPE_PASS_FAIL
      if cr_status == Constants::GRADED_CRITERIA_STATUS_PASSED
        class_name = 'success'
      elsif cr_status == Constants::GRADED_CRITERIA_STATUS_FAILED
        class_name = 'danger'
      end
    elsif cr_type == Constants::CRITERIA_TYPE_POINT
      if cr_point > 0
        class_name ='success'
      else
        class_name = 'danger'
      end
    end

    class_name
  end
end
