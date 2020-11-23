class CustomersController < ApplicationController
  def index
    if @current_customer.nil?
      # user is not logged in
      redirect_to customers_auth_path
    end
  end

  def auth
    @error_message = flash[:error_message] if flash[:error_message]
    @provinces = Province.all
  end

  def register
    begin
      # User params
      user_name = params["name"]
      user_email = params["email"]
      user_password = params["password"]
      user_password_confirmation = params["password_confirmation"]
      user_address = params["address"]
      user_city = params["city"]
      user_postal_code = params["postal_code"]
      user_country = params["country"]
      user_province_code = params["province_code"]

      province = Province.find_by(code: user_province_code)
      customer = Customer.create!(
        name:                  user_name,
        email:                 user_email,
        password:              user_password,
        password_confirmation: user_password_confirmation,
        address_line:          user_address,
        city:                  user_city,
        postal_code:           user_postal_code,
        country:               user_country,
        province:              province
      )
    rescue StandardError => e
      customer = nil
      @error_message = e.message
    end
    # province_id: province.id
    if customer
      session[:customer_id] = customer.id
      redirect_to customers_path
      nil
    else
      if @error_message.nil?
        @error_message = "Something went wrong when registering, please try again."
      end
      redirect_to(customers_auth_path, { flash: { error_message: @error_message } })
      nil
    end
  end

  def login
    unless params["password"] == params["password_confirmation"]
      @error_message = "Sorry, password and password confirmation must match, please try again."
      redirect_to(customers_auth_path, { flash: { error_message: @error_message } })
      return
    end
    customer = Customer
               .find_by(email: params["email"])
               .try(:authenticate, params["password"])
    if customer
      session[:customer_id] = customer.id
      redirect_to customers_path
      nil
    else
      @error_message = "Something went wrong logging in, please check credentials and try again."
      redirect_to(customers_auth_path, { flash: { error_message: @error_message } })
      nil
    end
  end

  def logout
    reset_session
    redirect_to root_path
  end
end
