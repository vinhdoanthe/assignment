RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)


  config.authorize_with do
    redirect_to main_app.root_path unless current_user.admin?
  end

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard do
      # statistics false
    end # mandatory
    index # mandatory
    new do
      except ['SubmissionGrade', 'GradedRubric']
    end
    export
    bulk_delete
    show
    edit
    delete do
      # except ['GradedRubric']
    end
    # use rails_admin_import gem
    import do
      except ['SubmissionGrade', 'GradedRubric']
    end
    # show_in_app

    ## With an audit adapter, you can add:
    # history_index do
    #   only ['SubmissionGrade']
    # end
    # history_show do
    #   only ['SubmissionGrade']
    # end

    # select do
    #   only ['SubmissionGrade']
    # end
  end

  config.configure_with(:import) do |config|
    config.logging = true
    config.update_if_exists = true
    config.rollback_on_error = true
  end

  config.model 'SubmissionGrade' do
    weight -2
    list do
      sort_by :created_at
      filters [:submission_status, :created_at]
      configure :id do
        hide
      end
      configure :updated_at do
        hide
      end
      configure :attempt_count do
        hide
      end
      configure :latest do
        hide
      end
      configure :graded_rubric do
        hide
      end
      configure :submission_file do
        hide
      end
      configure :graded_file do
        hide
      end
    end
  end
  config.model User do
    weight -1
    object_label_method :display_name

    edit do
      configure :created_at do
        hide
      end
      configure :created_at do
        hide
      end
      configure :reset_password_sent_at do
        hide
      end
      configure :remember_created_at do
        hide
      end
      configure :funid do
        hide
      end
    end
  end

  config.model GradedRubric do
    parent SubmissionGrade
    object_label_method :display_name
  end

  config.model CourseInstance do
    parent Course
    object_label_method :display_name
  end

  config.model Assignment do
    parent CourseInstance
    object_label_method :display_name
  end

  config.model Rubric do
    parent Assignment
    object_label_method :display_name
  end

  config.model CriteriaFormat do
    parent Rubric
    object_label_method :display_name
    visible false
    edit do
      fields :rubric, :index, :description, :max_point, :weighted, :required
    end
  end

  config.model GradedCriterium do
    parent GradedRubric
    visible false
  end

end
