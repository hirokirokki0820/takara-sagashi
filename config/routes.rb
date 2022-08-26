Rails.application.routes.draw do
  root "home#top"
  get "host_user", to: "home#host_user"
  get "signup", to: "users#new"
  get "guest_login", to: "users#guest_login"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  resources :users, except: [:new] do
    member do
      get "show_qrcode"
    end
  end
  resources :posts do
    member do
      get "show_qrcodes"
      get "activation_reset"
    end
    resources :items do
      member do
        get "activate_item"
      end
    end
  end

end
