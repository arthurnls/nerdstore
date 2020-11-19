class OrdersController < ApplicationController
  def index; end

  def show; end

  def cart; end

  def add_to_cart
    product_id = params[:id].to_i
    session[:cart] << product_id unless session[:cart].include?(product_id)
    redirect_to request.referer
  end

  def remove_from_cart; end
end
