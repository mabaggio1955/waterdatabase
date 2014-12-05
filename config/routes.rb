Rails.application.routes.draw do
  scope "(:locale)" do
    get 'pages/dashboard'
    get 'pages/home'

    resources :contents do
      resources :documents, only: [:destroy, :create]
    end

    resources :categories, only: [:index]

    match "/auth/:provider/callback" => "sessions#create", as: :auth_callback, via: :get
    match "/auth/failure" => "sessions#failure", as: :auth_failure, via: :get
    match "/logout" => "sessions#destroy", as: :logout, via: :get
    resources :sessions, only: [:create, :destroy]
  end

  root 'pages#home'
  get '/:locale' => 'contents#index'
end
