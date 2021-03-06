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
  resources :submission_grades, only: %i[show index]
  resources :graded_rubrics, only: %i[new show]
  
  # Custom routes
  root to: 'home#index'
  get 'active_assignments', to: 'assignments#active_assignments'
  get 'assigned_submissions', to: 'submission_grades#assigned_submissions'
  get 'submit_solution', to: 'submission_grades#new_solution', as: :new_solution
  post 'submission_grades', to: 'submission_grades#create', as: :submit_solution
  post 'submission_grades/:id', to: 'submission_grades#report_invalid', as: :report_invalid_submission
  get 'grade_form', to: 'submission_grades#grade_form', as: :grade_form
  post 'pre_caculate_grade', to: 'submission_grades#pre_caculate_grade', as: :pre_caculate_grade
  post 'grade_submission', to: 'submission_grades#grade', as: :grade_submission
  get 'graded_rubrics/preview', to: 'graded_rubrics#preview_get', as: :get_preview_rubric
  post 'graded_rubrics/preview', to: 'graded_rubrics#preview', as: :preview_rubric
  post 'graded_rubrics/pre_caculate', to: 'graded_rubrics#pre_caculate', as: :pre_caculate_rubric
  post 'graded_rubrics', to: 'graded_rubrics#grade', as: :grade_rubric
  post 'import_enrollments', to: 'enrollments#import_enrollments', as: :import_enrollments
  post 'reset_results', to: 'enrollments#reset_results', as: :reset_results
end
