Rails.application.routes.draw do
  devise_for :users
  resources :scheduled_meals
  resources :meals
  resources :schedules, except: :destroy
  root 'static_pages#home'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
end
