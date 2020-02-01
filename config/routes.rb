Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'application#hello', as: :authenticated_root
  end
  root 'static_pages#home'
  resources :scheduled_meals do
    collection do
      post 'attach_suggested_meal'
    end
  end
  resources :meals
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
end
