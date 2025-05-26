# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  get 'users', to: 'users#index'
  namespace :users do
    resources :recipes do
      resource :favorite, only: %i[create destroy]
      collection do
        get 'mypage'
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root to: 'home#index'
end
