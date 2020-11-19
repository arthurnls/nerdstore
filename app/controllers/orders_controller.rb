class OrdersController < ApplicationController
  def index; end

  def show; end

  def cart; end

  def add_to_cart
    product_id = params[:id].to_i
    cart_action = params[:cart_action]
    unless session[:cart].any? { |hash| hash["product"] == product_id }
      session[:cart] << { product: product_id, qty: 1 }
    end
    if cart_action == "+"
      session[:cart].each do |item|
        next unless item["product"] == product_id

        item["qty"] += 1
        break
      end
    elsif cart_action == "-"
      session[:cart].each do |item|
        next unless item["product"] == product_id

        item["qty"] -= 1
        if item["qty"].zero?
          remove_from_cart
          return
        end
      end
    end

    redirect_to request.referer
  end

  def remove_from_cart
    product_id = params[:id].to_i
    session[:cart].delete_if { |cart_item| cart_item["product"] == product_id }
    redirect_to request.referer
  end
end
