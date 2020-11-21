Rails.application.routes.draw do
  root to: "products#index"

  ##################################
  # Pages Routes
  get "about", to: "pages#about"
  get "contact", to: "pages#contact"
  get "search", to: "pages#search", as: "search"

  ##################################
  # Orders Routes
  get "orders/cart", to: "orders#cart", as: "cart"
  post "orders/add_to_cart/:id", to: "orders#add_to_cart", as: "add_to_cart"
  delete "orders/remove_from_cart/:id", to: "orders#remove_from_cart", as: "remove_from_cart"
  resources "orders", only: %i[index show]

  ##################################
  # Checkout Routes
  scope "/checkout" do
    post "create", to: "checkout#create", as: "checkout_create"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
    get "success", to: "checkout#success", as: "checkout_success"
  end

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
  # Customers Routes
  # resources "customers", only: %i[index login logout register]
  scope "/customers" do
    get "index", to: "customers#index", as: "customers_index"
    post "login", to: "customers#login", as: "customers_login"
    post "register", to: "customers#register", as: "customers_register"
    get "logout", to: "customers#logout", as: "customers_logout"
  end

  ##################################
  # Active Admin Routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
