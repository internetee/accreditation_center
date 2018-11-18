Rails.application.routes.draw do
  devise_for :administrators

  namespace :admin do
    authenticated :administrator do
      root 'questions#index', as: :authenticated_root
    end

    resources :questions
  end

  root 'home#index'
end
