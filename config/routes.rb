Rails.application.routes.draw do
  get 'results/index'
  root 'home#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  # scope :api, defaults: { format: json } do
  #   devise_for :users
  # end

  resources :answer_questions, only: [ :create ]
  
  resources :quiz, only: [ :show ] do
    resources :categories, only: [ :show ]
    resources :questions, only: [ :show ]
  end

  resources :categories, only: [ :show ] do
    resources :results, only: [ :show ]
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
