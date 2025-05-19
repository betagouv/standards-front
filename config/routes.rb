Rails.application.routes.draw do
  root to: "home#index"
  get "standards", to: "home#standards"

  get "auth/:provider/callback", to: "sessions#create"
  get "auth/:provider/logout", to: "sessions#destroy"

  get "/login", to: "sessions#new"

  get "/auth/proconnect/logged_out", to: "sessions#proconnect_logged_out"

  delete "/logout", to: "sessions#destroy"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :startups, param: :ghid, constraints: { ghid: /[^\/]+/ }, only: :index do
    resource :audit, only: %i[show update] do
      get ":category", to: "audits#category", as: :category
      get ":category/:question", to: "audits#question", as: :category_question
    end
  end

  mount Audits::API => "/api"
end
