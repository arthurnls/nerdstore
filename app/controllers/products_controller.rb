class ProductsController < ApplicationController
  def index
    @products = Product.includes(:brand, { category: [:department] }, :images).all
  end

  def show
    @product = Product.includes(:brand, { category: [:department] }, :images).find(params[:id])
  end
end
