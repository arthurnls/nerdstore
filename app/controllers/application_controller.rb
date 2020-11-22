class ApplicationController < ActionController::Base
  before_action :initialize_session
  before_action :load_cart
  before_action :authentication

  private

  def initialize_session
    session[:cart] ||= []
  end

  def load_cart
    @cart = []
    session[:cart].each do |item|
      product = Product.find(item["product"])
      qty = item["qty"]
      @cart << { product: product, qty: qty }
    end

    if @cart.any?
      @subtotal = 0
      @total_items = 0
      @cart.each do |cart_item|
        @subtotal += cart_item[:product].price * cart_item[:qty]
        @total_items += cart_item[:qty]
      end
    end
  end

  def authentication
    @current_customer = Customer.find(session[:customer_id]) if session[:customer_id]
  end
end
