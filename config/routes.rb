Rails.application.routes.draw do
  resources :scheduled_meals
  resources :meals
  resources :schedules, only: [:index, :show, :new, :create, :edit, :update, ]
  root 'static_pages#home'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
end
