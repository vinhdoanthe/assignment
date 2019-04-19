Rails.application.routes.draw do
  resources :submission_grades
  resources :enrollments
  devise_for :users
  resources :graded_rubrics
  resources :rubrics
  resources :assignments
  resources :course_instances
  resources :programs
  resources :courses
  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
