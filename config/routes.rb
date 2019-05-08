Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :admin do
    resources :courses do
        resources :course_instances
    end
    resources :programs do
        resources :course_instances
    end
    resources :course_instances do
      resources :assignments
    end
    resources :assignments do
      resources :rubrics
    end
  end

  resources :graded_criteria
  resources :criteria_formats
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #resources :admins
  resources :submission_grades do
    post 'assign_mentor', :on => :collection
  end
  resources :enrollments
  devise_for :users
  resources :graded_rubrics
  resources :rubrics
  resources :assignments
  resources :course_instances
  resources :programs
  resources :courses
  root to: "home#index"

  get 'get_assignments_by_course_instance/:course_instance_id', to: 'assignments#get_assignments_by_course_instance'
  get 'my_courses', to: 'course_instances#my_courses'
  get 'list_assignments_of_course', to: 'course_instances#list_assignments_of_course'
  get 'active_assignments', to: 'assignments#active_assignments'
  get 'assigned_submissions', to: 'submission_grades#assigned_submissions'
  get 'grade_submission', to: 'submission_grades#grade'
  post 'grade_submission', to: 'submission_grades#update_grade'
end
