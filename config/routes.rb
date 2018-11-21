Rails.application.routes.draw do
  devise_for :administrators

  namespace :admin do
    authenticated :administrator do
      root 'questions#index', as: :authenticated_root
    end

    resources :questions
    resources :categories
    resources :tests, only: %i[index show]
  end

  root 'home#index'
end
