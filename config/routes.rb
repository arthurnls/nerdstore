Rails.application.routes.draw do
  root to: "products#index"

  get "pages/account"
  get "pages/about"
  get "pages/contact"
  get "pages/cart"
  get "pages/checkout"

  get "products/index"
  get "products/show"

  get "categories/index"
  get "categories/show"

  get "departments/show"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
