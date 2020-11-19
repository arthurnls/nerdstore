class OrdersController < ApplicationController
  def index; end

  def show; end

  def cart
    @subtotal = 0
    @total_items = 0
    @cart.each do |product|
      @subtotal += product.price
      @total_items += 1
    end
  end

  def add_to_cart
    product_id = params[:id].to_i
    session[:cart] << product_id unless session[:cart].include?(product_id)
    redirect_to request.referer
  end

  def remove_from_cart
    product_id = params[:id].to_i
    session[:cart].delete(product_id)
    redirect_to request.referer
  end
end
