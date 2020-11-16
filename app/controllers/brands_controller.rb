class BrandsController < ApplicationController
  def index
    @brands = Brand.includes(:products).order(:name)
  end

  def show
    @brand = Brand.includes(:products).order("products.name").find(params[:id])
    @products = @brand.products.page(params[:page])
  end
end
