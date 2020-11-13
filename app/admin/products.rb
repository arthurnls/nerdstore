ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock_quantity, :brand_id, :category_id, images: []

  # Formtastic gem
  form(html: { multipart: true }) do |f|
    f.semantic_errors # show errors on :base
    f.inputs          # builds an input field for every attribute
    f.inputs do
      f.input :images, as: :file, input_html: { multiple: true }
    end
    f.actions         # adds the Submit and Cancel buttons
  end

  show do
    attributes_table do
      row :images do
        div do
          product.images.each do |img|
            div do |d|
              image_tag url_for(img), size: "150x150"
            end
          end
        end
      end
    end
    default_main_content
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
