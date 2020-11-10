class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:products, :department).all
  end

  def show
    @category = Category.includes(:products, :department).find(params[:id])
  end
end
