# frozen_string_literal: true

Rails.application.routes.draw do
  resources :job_matrices
  resources :jobs, only: %i[index show]
  resources :build_results
  devise_for :users
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  scope '(:locale)', locale: /en/ do
    # root to: 'pages#home'
    root to: 'job_matrices#index'
  end
end
