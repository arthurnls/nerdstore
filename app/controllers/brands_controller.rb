class BrandsController < ApplicationController
  def index
    @brands = Brand.includes(:products).order(:name)
  end

  def show
    @filter = params[:filter]
    @brand = Brand.includes(:products).order("products.name").find(params[:id])
    @products = if @filter == "new"
                  @brand.products
                        .where(created_at: (Date.today - 3.days)..Date.today + 1)
                        .page(params[:page]).order(:name)
                elsif @filter == "recent"
                  @brand.products
                        .where(updated_at: (Date.today - 3.days)..Date.today + 1)
                        .page(params[:page]).order(:name)
                else
                  @brand.products.page(params[:page]).order(:name)
                end
  end
end
