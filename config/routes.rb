Rails.application.routes.draw do
  resources :trips, only: [:index, :show, :new, :create]
  root "trips#index"

  namespace :api do
    namespace :v1 do
      resources :trips, only: [:index, :show, :create]
    end
  end
end