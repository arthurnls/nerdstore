class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:products, :department).order(:name)
  end

  def show
    @category = Category.includes(:products, :department).order("products.name").find(params[:id])
    @products = @category.products.page(params[:page])
  end
end
