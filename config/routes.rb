Rails.application.routes.draw do
  root to: "home#index"
  get 'about/index'
  get 'home/index'
  get 'animes/index'
  get 'animes/show'

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
