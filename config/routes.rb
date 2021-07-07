Rails.application.routes.draw do
  # get 'admin_dashboard/index'
  devise_for :administrators

  namespace :admin do
    authenticated :administrator do
      root 'admin_dashboard#index', as: :authenticated_root
    end

    resources :questions do
      member do
        patch :activate
        patch :deactivate
      end
    end

    resources :categories, except: %i[show]
    resources :exams, only: %i[index show]
  end

  root 'home#index'
end
