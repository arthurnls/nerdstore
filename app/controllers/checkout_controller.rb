class CheckoutController < ApplicationController
  def create
    if @cart.count == 0 || @current_customer.nil?
      redirect_to request.referer
      return
    end
    subtotal = @subtotal
    ######################################
    ######## SETUP PRODUCTS LIST #########
    # Setup the products array to pass on to Stripe session
    product_models = []
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
      product_models << {
        product: product,
        qty:     qty
      }
    end
    ######################################

    ######################################
    ###### MUST CREATE ORDER PENDING #####
    shipping_address = @current_customer.address_line
    shipping = 0
    discount = 0
    gst = if @current_customer.province.tax_gst.nil?
            0
          else
            @current_customer.province.tax_gst / 100
          end
    pst = if @current_customer.province.tax_pst.nil?
            0
          else
            @current_customer.province.tax_pst / 100
          end
    hst = if @current_customer.province.tax_hst.nil?
            0
          else
            @current_customer.province.tax_hst / 100
          end
    subtotal += shipping - discount
    gst_cost = subtotal * gst
    pst_cost = subtotal * pst
    hst_cost = subtotal * hst
    order = @current_customer.orders.create(
      cost_shipping:    shipping,
      cost_GST:         gst_cost,
      cost_PST:         pst_cost,
      cost_HST:         hst_cost,
      cost_discount:    discount,
      shipping_address: shipping_address,
      status:           "pending"
    )
    # customer:         @current_customer,
    # STATUS: pending paid shipped
    ######################################
    # Add taxes products array to pass on to Stripe session
    taxes = subtotal * (gst + pst + hst)
    tax_percent_text = format("%.2f", ((gst + pst + hst) * 100))
    products << {
      name:     "Sales Taxes (#{tax_percent_text}%)",
      amount:   (taxes * 100).to_i,
      currency: "cad",
      quantity: 1
    }
    ######################################
    ########## ORDER DETAILS ############
    product_models.each do |item|
      order.order_details.create!(
        quatity:        item[:qty],
        purchase_price: item[:product].price,
        product:        item[:product]
      )
    end

    ######################################

    ######################################
    ############ STRIPE PAYMMENT #########
    begin
      # Settign up a Stripe Session for payment.
      @session = Stripe::Checkout::Session.create(
        payment_method_types: ["card"],
        line_items:           products,
        success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}&order=#{order.id}",
        cancel_url:           checkout_cancel_url
      )
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error: #{e.message}"
      redirect_to request.referer
      nil
    end
    ######################################
  end

  def success
    # load session
    session_id = params[:session_id]
    order_id = params[:order]
    @session = Stripe::Checkout::Session.retrieve(session_id)
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    ######################################
    ## MUST CHANGE STATUS ORDER TO PAID ##
    order = Order.find(order_id)
    order.status = "paid"
    order.save
    ######################################
    session[:cart] = []
  end

  def cancel; end
end
