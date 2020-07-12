Rails.application.routes.draw do
  resources :ingredients
  devise_for :users

  authenticated :user do
    root 'landing#index', as: :authenticated_root
  end
  root 'static_pages#home'
  resources :scheduled_meals do
    collection do
      post 'attach_suggested_meal'
    end
  end

  post '/meals/tag', to: 'meals#tag'
  delete '/meals/untag', to: 'meals#untag'
  resources :meals
  resources :tags
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  get 'feedback/new', to: 'static_pages#feedback_new'
  post 'feedback', to: 'static_pages#feedback_post'
end
