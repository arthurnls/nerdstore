class ProductsController < ApplicationController
  def index
    @products = Product.includes(:brand, { category: [:department] }).page(params[:page]).order(:name)
  end

  def show
    @product = Product.includes(:brand, { category: [:department] }).find(params[:id])
  end
end
