class PagesController < ApplicationController
  def account; end

  def about; end

  def contact; end

  def cart; end

  def checkout; end

  # GET /search/?search_term=user+search+terms
  def search
    @searched_term = params[:search_term]
    if params[:category][:id].present?
      search_category_id = params[:category][:id]
      @category = Category.find(search_category_id)
    end

    if @category.nil?
      # Search the full list of products from Product.all
      @products = Product.includes(:brand, { category: [:department] })
                         .where("name LIKE ? OR description LIKE ?", "%#{@searched_term}%", "%#{@searched_term}%")
                         .page(params[:page]).order(:name)
    else
      # Search the list of products from category.products
      @products = @category.products.includes(:brand, { category: [:department] })
                           .where("name LIKE ? OR description LIKE ?", "%#{@searched_term}%", "%#{@searched_term}%")
                           .page(params[:page]).order(:name)
    end
  end
end
