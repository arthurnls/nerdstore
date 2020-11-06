class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.includes(:brand, :category, :images).find(params[:id])
  end
end
