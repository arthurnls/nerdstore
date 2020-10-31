Rails.application.routes.draw do
  root to: "products#index"

  get "pages/account"
  get "pages/about"
  get "pages/contact"
  get "pages/cart"
  get "pages/checkout"

  resources "products", only: %i[index show]

  resources "categories", only: %i[index show]

  resources "departments", only: %i[show]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
