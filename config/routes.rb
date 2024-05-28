Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  resources :teachers
  resources :students
  resources :articles

  resources :teacher_sessions, only: [:new, :create, :destroy]
  resources :student_sessions, only: [:new, :create, :destroy]

  get "articles/:id/add_comment", to: "articles#new_comment" , as: :new_comment
  post "articles/:id/add_comment", to: "articles#add_comment", as: :add_comment

  # Defines the root path route ("/")
  # root "posts#index"
end
