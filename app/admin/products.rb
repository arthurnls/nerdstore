ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock_quantity, :brand_id, :category_id, :asimages

  # Formtastic gem
  form do |f|
    f.semantic_errors # show errors on :base
    f.inputs          # builds an input field for every attribute
    f.inputs do
      f.input :asimages, as: :file
    end
    f.actions         # adds the Submit and Cancel buttons
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :price, :stock_quantity, :brand_id, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
