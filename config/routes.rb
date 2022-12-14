Rails.application.routes.draw do
  devise_for :users
  get "contexts/home"
  get "contexts/about"

  get "types/index"
  get "types/show"
  get "types/new_type"
  get "types/recent_update"
  get "types/on_sale"

  get "products/index"
  get "products/show"
  get "products/find"

  get "images/index"
  get "images/show"
  get "images/new_image"
  get "images/recent_update"
  get "images/on_sale"

  get "animes/index"
  get "animes/show"

  get "cart/show"
  get "cart/checkout"

  get "orders/index"
  get "orders/show"
  get "orders/admin"

  scope "/checkout" do
    post  "create",   to: "checkout#create",  as: "checkout_create"
    get   "success",  to: "checkout#success", as: "checkout_success"
    get   "cancel",   to: "checkout#cancel",  as: "checkout_cancel"
  end

  root to: "contexts#home"

  resources :types, only: %i[index show new_type recent_update on_sale]
  resources :products, only: %i[index show find]
  resources :images, only: %i[index show new_type recent_update on_sale]
  resources :contexts, only: %i[home about]
  resources :cart, only: %i[create destroy show checkout]
  resources :order_items
  resources :orders

  resources :animes, only: %i[index show] do
    # movies/search/(:format)
    collection do
      get "search"
    end

    get "/page/:page", action: :index, on: :collection
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
