Rails.application.routes.draw do
  root to: "users#new"
  # get 'sessions/new'
  
  get  "/help",    to: "static_pages#help"
  get  "/about",   to: "static_pages#about"
  get  "/signup",  to: "users#new"

  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"

  get    "/logout",  to: "sessions#confirm_logout", as: :confirm_logout
  delete "/logout",  to: "sessions#destroy"
  resources :users
  resources :tweets,          only: [:create, :destroy]
end
