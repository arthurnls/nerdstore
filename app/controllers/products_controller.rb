class ProductsController < ApplicationController
  def index
    @filter = params[:filter]
    @products = if @filter == "new"
                  Product.includes(:brand, { category: [:department] })
                         .where(created_at: (Date.today - 3.days)..Date.today + 1)
                         .page(params[:page]).order(:name)
                elsif @filter == "recent"
                  Product.includes(:brand, { category: [:department] })
                         .where(updated_at: (Date.today - 3.days)..Date.today + 1)
                         .page(params[:page]).order(:name)
                else
                  Product.includes(:brand, { category: [:department] })
                         .page(params[:page]).order(:name)
                end
  end

  def show
    @product = Product.includes(:brand, { category: [:department] }).find(params[:id])
    @is_on_cart = false
    session[:cart].each do |item|
      if item["product"] == @product.id
        @is_on_cart = true
        break
      end
    end
  end
end
