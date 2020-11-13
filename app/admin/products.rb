ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock_quantity, :brand_id, :category_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :price, :stock_quantity, :brand_id, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
