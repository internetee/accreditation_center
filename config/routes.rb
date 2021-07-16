Rails.application.routes.draw do
  resources :quiz, only: [ :show ]
  resources :categories, only: [ :show ]

  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'
  resources :questions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
