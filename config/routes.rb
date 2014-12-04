Rails.application.routes.draw do
  get 'pages/dashboard'
  get 'pages/home'

  resources :contents do
    resources :documents, only: [:destroy, :create]
  end

  match "/auth/:provider/callback" => "sessions#create", as: :auth_callback, via: :get
  match "/auth/failure" => "sessions#failure", as: :auth_failure, via: :get
  match "/logout" => "sessions#destroy", as: :logout, via: :get
  resources :sessions, only: [:create, :destroy]

  root 'pages#home'
end
