ActiveAdmin.register Customer do
  permit_params :name, :email, :password, :address_line, :city, :postal_code, :country, :province_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :password, :address_line, :city, :postal_code, :country, :province_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
