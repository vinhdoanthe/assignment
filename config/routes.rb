# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  ActiveAdmin.routes(self)

  # Routes for ActiveAdmin
  namespace :admin do
    resources :courses do
      resources :course_instances
    end
    resources :programs do
      resources :course_instances
    end
    resources :course_instances do
      resources :assignments
      resources :enrollments
    end
    resources :assignments do
      resources :rubrics
    end
    resources :submission_grades do
      resources :graded_rubrics
    end
  end

  # Routes for submit and grade students' solution
  resources :submission_grades, only: %i[show list]
  resources :graded_rubrics, only: %i[show]

  # resources :graded_criteria
  # resources :enrollments
  # resources :criteria_formats
  # resources :rubrics
  # resources :assignments
  # resources :course_instances
  # resources :programs
  # resources :courses

  # Custom routes
  root to: 'home#index'
  get 'get_assignments_by_course_instance/:course_instance_id', to: 'assignments#get_assignments_by_course_instance'
  get 'my_courses', to: 'course_instances#my_courses'
  get 'list_assignments_of_course', to: 'course_instances#list_assignments_of_course'
  get 'active_assignments', to: 'assignments#active_assignments'
  get 'assigned_submissions', to: 'submission_grades#assigned_submissions'
  get 'grade_submission', to: 'submission_grades#grade'
  post 'grade_submission', to: 'submission_grades#update_grade'
end
