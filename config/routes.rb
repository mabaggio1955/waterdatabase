Rails.application.routes.draw do
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
  end

  match "/auth/:provider/callback" => "sessions#create", as: :auth_callback, via: :get
  match "/auth/failure" => "sessions#failure", as: :auth_failure, via: :get
  match "/logout" => "sessions#destroy", as: :logout, via: :get
  resources :sessions, only: [:create, :destroy]

  root 'pages#home'
  get '/:locale' => 'categories#index'
end
