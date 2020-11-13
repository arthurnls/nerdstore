ActiveAdmin.register Province do
  permit_params :code, :name
  #
  # or
  #
  # permit_params do
  #   permitted = [:code, :name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
