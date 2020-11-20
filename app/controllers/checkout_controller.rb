class CheckoutController < ApplicationController
  def create
    if @cart.count == 0
      redirect_to request.referer
      return
    end

    # Setup the products array to pass on to Stripe session
    products = []
    @cart.each do |item|
      product = item[:product]
      qty = item[:qty]
      products << {
        name:     product.name,
        amount:   (product.price * 100).to_i,
        currency: "cad",
        quantity: qty
      }
    end
    taxes = @subtotal * get_taxes_percent
    tax_percent_text = format("%.2f", (get_taxes_percent * 100))
    products << {
      name:     "Sales Taxes (#{tax_percent_text}%)",
      amount:   (taxes * 100).to_i,
      currency: "cad",
      quantity: 1
    }

    ######################################
    ###### MUST CREATE ORDER PENDING #####
    ######################################

    begin
      # Settign up a Stripe Session for payment.
      @session = Stripe::Checkout::Session.create(
        payment_method_types: ["card"],
        line_items:           products,
        success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
        cancel_url:           checkout_cancel_url
      )
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error: #{e.message}"
      redirect_to request.referer
      nil
    end
  end

  def success
    # load session
    session_id = params[:session_id]
    @session = Stripe::Checkout::Session.retrieve(session_id)
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    ######################################
    ## MUST CHANGE STATUS ORDER TO PAID ##
    ######################################
  end

  def cancel; end

  private

  def get_taxes_percent
    0.12
  end
end
