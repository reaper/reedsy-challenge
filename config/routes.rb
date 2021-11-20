Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products, only: %w[index show]
    end
  end
end
