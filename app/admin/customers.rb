ActiveAdmin.register Customer do
  permit_params :name, :email, :password, :address_line, :city, :postal_code, :country, :province_id

  form do |f|
    f.inputs do
      f.input :province
      f.input :name
      f.input :password
      f.input :email
      f.input :address_line
      f.input :city
      f.input :postal_code
      f.input :country
    end
    f.actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :password, :address_line, :city, :postal_code, :country, :province_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
