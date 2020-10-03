class SubmissionGradeDecorator < SimpleDelegator

  def assigned_at_frm
    return '' if assigned_at.nil?

    assigned_at.strftime(I18n.t('date.formats.default'))
  end

  def point_frm
    point
  end

end
