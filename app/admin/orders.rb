ActiveAdmin.register Order do
  permit_params :cost_shipping, :cost_GST, :cost_PST, :cost_HST, :cost_discount, :shipping_address, :status, :customer

  #
  # or
  #
  # permit_params do
  #   permitted = [:cost_shipping, :cost_GST, :cost_PST, :cost_HST, :cost_discount, :shipping_address]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
