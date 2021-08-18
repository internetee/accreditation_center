Rails.application.routes.draw do
  get 'results/index'
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

  # practice endpoints
  get 'practice/index'
  get 'practice/contact'

  resources :results, only: [ :show ]


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
