Rails.application.routes.draw do
  get 'invoice/index'
  get 'invoice/create'
  get 'delete/index'
  get 'delete/create'
  root 'home#index'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  

  resources :answer_questions, only: [ :create ]
  
  resources :quiz, only: [ :show ] do
    resources :categories, only: [ :show ]
    resources :questions, only: [ :show ]
  end

  get '/quiz_prepare/:id', to: 'quiz#prepare', as: 'quiz_prepare'
  
  resources :results, only: [ :index, :show ]
  resources :practice, only: [ :index ]

  namespace :practice do
    resources :contact, only: [ :index ]
    resources :domains, only: [ :index, :create ]
    resources :nameserver, only: [ :index, :create ]
    resources :transfer, only: [ :index, :create ]
    resources :renew, only: [ :index, :create ]
    resources :change_registrant_email, only: [ :index, :create ]
    resources :change_registrant_verification, only: [ :index, :create ]
    resources :delete, only: [ :index, :create ]
    resources :invoice, only: [ :index, :create ]
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
