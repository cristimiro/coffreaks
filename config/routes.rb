Rails.application.routes.draw do
  post "/graphql/admin", to: "graphql/admin#execute"
  post "/graphql/public", to: "graphql/public#execute"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :coffee_shops, only: [ :index ] do
    collection do
      get :nearby
    end
  end
  # Defines the root path route ("/")
  root "application#index"
end
