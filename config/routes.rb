Rails.application.routes.draw do
  root "home#index"
  get "signup", to: "users#new"
  get "guest", to: "users#guest_login"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  # post "guest", to: "guest_users#create"
  # delete "guest_logout", to "guest_users#destroy"
  resources :users, except: [:new]
  resources :posts
  # resources :guest_users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
