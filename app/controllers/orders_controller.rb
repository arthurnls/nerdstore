class OrdersController < ApplicationController
  def index
    @orders = @current_customer.orders.order("created_at DESC")
  end

  def show
    if @current_customer.nil?
      # user is not logged in
      redirect_to customers_auth_path
    else
      @order = Order.includes(:products).find(params[:id])
      @total_products_cost = 0
      @order.order_details.each do |detail|
        @total_products_cost += (detail.purchase_price * detail.quatity)
      end
      @total_before_tax = @total_products_cost + @order.cost_shipping - @order.cost_discount
      @total_after_tax = @total_before_tax + @order.cost_GST + @order.cost_PST + @order.cost_HST
    end
  end

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
