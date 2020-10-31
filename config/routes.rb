Rails.application.routes.draw do
  get 'products/index'
  get 'products/show'
  get 'categories/index'
  get 'categories/show'
  get 'departments/show'
  get 'pages/account'
  get 'pages/about'
  get 'pages/contact'
  get 'pages/cart'
  get 'pages/checkout'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
