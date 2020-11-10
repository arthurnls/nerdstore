Rails.application.routes.draw do
  root to: "products#index"

  get "about", to: "pages#about"
  get "contact", to: "pages#contact"
  get "account", to: "pages#account"
  get "cart", to: "pages#cart"
  get "checkout", to: "pages#checkout"

  resources "products", only: %i[index show]

  resources "categories", only: %i[index show]

  resources "departments", only: %i[show]

  resources "brands", only: %i[index show]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
