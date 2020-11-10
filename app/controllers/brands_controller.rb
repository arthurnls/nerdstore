class BrandsController < ApplicationController
  def index
    @brands = Brand.includes(:products).all
  end

  def show
    @brand = Brand.includes(products: :images).find(params[:id])
  end
end
