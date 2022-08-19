Rails.application.routes.draw do
  root "home#index"
  get "signup", to: "users#new"
  get "guest", to: "users#guest_login"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "activation_reset", to: "posts#activation_reset"
  resources :users, except: [:new]
  resources :posts do
    resources :items
  end
end
