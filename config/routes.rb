Rails.application.routes.draw do
  get 'profils/theme'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  require "sidekiq/web"
  # get "/dashboard", to: 'pages#dashboard'
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  resources :shop_products
  get "/gamme", to: 'shop_products#gamme'
  get "/trier", to: 'shop_products#destroy_to_remove'
  # patch "/trier", to: 'shop_products#destroy_to_remove'
  get "/search_products", to: 'shop_products#search_products', as: "search"
  post "/replace/:shop_product_id", to: 'shop_products#replace', as:"replace"

  resources :orders, only: [:index, :show]

  get "/index", to: 'shop_products#index'
  resources :products, only:[:index]


  get "/dashboard", to: 'pages#dashboard'

  get "/theme", to: "profils#theme"

  get "/orders/:id/pdf", to: "orders#pdf", as: "pdf"

  get "/parameters", to: "parameters#index", as: "parameters"

end
