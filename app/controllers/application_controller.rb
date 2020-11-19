class ApplicationController < ActionController::Base
  before_action :initialize_session
  before_action :load_cart
  #   before_action :increment_visit_count

  private

  def initialize_session
    session[:cart] ||= []
  end

  def load_cart
    @cart = Product.find(session[:cart])
  end

  def increment_visit_count
    # session[:visit_count] += 1
    # @visit_count = session[:visit_count]
  end
end
