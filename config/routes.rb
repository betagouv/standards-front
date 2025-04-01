Rails.application.routes.draw do
  get "startups/index"
  get "startups/choix"
  root to: "startups#index"

  get "auth/:provider/callback", to: "sessions#create"
  get "/login", to: "sessions#new"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :startups do
    resource :audit
  end
end
