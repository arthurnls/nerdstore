class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:products, :department).order(:name)
  end

  def show
    @filter = params[:filter]
    @category = Category.includes(:products, :department).order("products.name").find(params[:id])
    @products = if @filter == "new"
                  @category.products
                           .where(created_at: (Date.today - 3.days)..Date.today + 1)
                           .page(params[:page]).order(:name)
                elsif @filter == "recent"
                  @category.products
                           .where(updated_at: (Date.today - 3.days)..Date.today + 1)
                           .page(params[:page]).order(:name)
                else
                  @category.products.page(params[:page]).order(:name)
                end
  end
end
