class PagesController < ApplicationController
  def account; end

  def about; end

  def contact; end

  def cart; end

  def checkout; end

  # GET /search/?search_term=user+search+terms
  def search
    @searched_term = params[:search_term]
    @filter = params[:filter]
    if params[:category][:id].present?
      search_category_id = params[:category][:id]
      @category = Category.find(search_category_id)
    end

    if @category.nil?
      # Search the full list of products from Product.all
      #
      @products = if @filter == "new"
                    Product.includes(:brand, { category: [:department] })
                           .where("name LIKE ? OR description LIKE ?", "%#{@searched_term}%", "%#{@searched_term}%")
                           .where(created_at: (Date.today - 3.days)..Date.today + 1)
                           .page(params[:page]).order(:name)
                  elsif @filter == "recent"
                    Product.includes(:brand, { category: [:department] })
                           .where("name LIKE ? OR description LIKE ?", "%#{@searched_term}%", "%#{@searched_term}%")
                           .where(updated_at: (Date.today - 3.days)..Date.today + 1)
                           .page(params[:page]).order(:name)
                  else
                    Product.includes(:brand, { category: [:department] })
                           .where("name LIKE ? OR description LIKE ?", "%#{@searched_term}%", "%#{@searched_term}%")
                           .page(params[:page]).order(:name)
                  end
    else
      # Search the list of products from category.products
      #
      @products = if @filter == "new"
                    @category.products.includes(:brand, { category: [:department] })
                             .where("name LIKE ? OR description LIKE ?", "%#{@searched_term}%", "%#{@searched_term}%")
                             .where(created_at: (Date.today - 3.days)..Date.today + 1)
                             .page(params[:page]).order(:name)
                  elsif @filter == "recent"
                    @category.products.includes(:brand, { category: [:department] })
                             .where("name LIKE ? OR description LIKE ?", "%#{@searched_term}%", "%#{@searched_term}%")
                             .where(updated_at: (Date.today - 3.days)..Date.today + 1)
                             .page(params[:page]).order(:name)
                  else
                    @category.products.includes(:brand, { category: [:department] })
                             .where("name LIKE ? OR description LIKE ?", "%#{@searched_term}%", "%#{@searched_term}%")
                             .page(params[:page]).order(:name)
                  end
    end
  end
end
