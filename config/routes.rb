Rails.application.routes.draw do
  root to: "products#index"

  ##################################
  # Pages Routes
  get "about", to: "pages#about"
  get "contact", to: "pages#contact"
  get "account", to: "pages#account"
  get "checkout", to: "pages#checkout"
  get "search", to: "pages#search", as: "search"

  ##################################
  # Orders Routes
  get "orders/cart", to: "orders#cart", as: "cart"
  post "orders/add_to_cart/:id", to: "orders#add_to_cart", as: "add_to_cart"
  delete "orders/remove_from_cart/:id", to: "orders#remove_from_cart", as: "remove_from_cart"
  resources "orders", only: %i[index show]

  ##################################
  # Products Routes
  resources "products", only: %i[index show]

  ##################################
  # Categories Routes
  resources "categories", only: %i[index show]

  ##################################
  # Departments Routes
  resources "departments", only: %i[show]

  ##################################
  # Brands Routes
  resources "brands", only: %i[index show]

  ##################################
  # Active Admin Routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
