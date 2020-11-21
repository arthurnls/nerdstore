class CustomersController < ApplicationController
  def index; end

  def register
    user_data = params["user"]
    # User params
    user_name = user_data["name"]
    user_email = user_data["email"]
    user_password = user_data["password"]
    user_password_confirmation = user_data["password_confirmation"]
    user_address = user_data["address"]
    user_city = user_data["city"]
    user_postal_code = user_data["postal_code"]
    user_country = user_data["country"]
    user_province_code = user_data["province_code"]

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
    # province_id: province.id
    if customer
      session[:customer_id] = customer.id
      redirect_to customers_path
    else
      @error_message = "Something went wrong when registering, please try again."
      redirect_to customers_path
    end
  end

  def login
    user_data = params["user"]
    customer = Customer
               .find_by(email: user_data["email"])
               .try(:authenticate, user_data["password"])
    if customer
      session[:customer_id] = customer.id
      redirect_to customers_path
    else
      @error_message = "Something went wrong login in, please try again."
      redirect_to customers_path
    end
  end

  def logout
    session[:customer_id] = nil
    @logged_in_user = nil
  end
end
