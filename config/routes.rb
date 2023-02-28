Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users
  resources :flats do
    resources :bookings, only: [:new, :create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
