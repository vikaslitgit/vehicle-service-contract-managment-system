Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do 
      resources :customers
      resources :vehicles

      resources :service_contracts do 
        collection do 
          get :active
          get :expired
        end
      end
    end
  end
end
