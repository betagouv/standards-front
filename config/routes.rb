Rails.application.routes.draw do
  root to: "home#index"

  get "home/index"

  # FIXME: these two routes
  get "home/choix_produit"
  post "choix_produit", to: "home#select_product"

  get "auth/:provider/callback", to: "sessions#create"
  get "/login", to: "sessions#new"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :startups do
    resource :audit
  end
end
