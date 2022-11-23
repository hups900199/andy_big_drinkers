Rails.application.routes.draw do
  get 'types/index'
  get 'types/show'
  get 'products/index'
  get 'products/show'
  get 'products/find'
  get 'images/index'
  get 'images/show'
  get 'about/index'
  get 'home/index'
  get 'animes/index'
  get 'animes/show'

  root to: "home#index"

  resources :types, only: [:index, :show]
  resources :products, only: [:index, :show, :find]
  resources :images, only: [:index, :show]

  resources :animes, only: [:index, :show] do
    #movies/search/(:format)
    collection do
      get "search"
    end

    get '/page/:page', action: :index, on: :collection
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
