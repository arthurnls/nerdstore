class ApplicationController < ActionController::Base
  before_action :initialize_session
  before_action :load_cart

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

    @subtotal = 0
    @total_items = 0
    @cart.each do |cart_item|
      @subtotal += cart_item[:product].price * cart_item[:qty]
      @total_items += cart_item[:qty]
    end
  end
end
