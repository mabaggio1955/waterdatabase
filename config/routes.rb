Rails.application.routes.draw do
  match "/auth/:provider/callback" => "sessions#create", as: :auth_callback, via: :get
  match "/auth/failure" => "sessions#failure", as: :auth_failure, via: :get
  match "/logout" => "sessions#destroy", as: :logout, via: :get
  resources :sessions, only: [:create, :destroy]

  scope "(:locale)" do
    get 'pages/home'

    resources :categories, only: [:show, :index] do
      resources :contents do
        resources :documents, only: [:destroy, :create]
      end
    end

    resources :contents do
      resources :documents, only: [:destroy, :create]
    end

    root 'pages#home'
  end

  get '/:locale' => 'categories#index'
end
