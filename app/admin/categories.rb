ActiveAdmin.register Category do
  permit_params :name, :department_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :department_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
