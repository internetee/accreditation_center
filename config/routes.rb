Rails.application.routes.draw do
  namespace :admin do
    resources :questions
  end

  root 'home#index'
end
