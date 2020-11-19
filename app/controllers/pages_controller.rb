class PagesController < ApplicationController
  def account; end

  def about; end

  def contact; end

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
    total_found = @products.count
    category_message = if @category.nil?
                         ""
                       else
                         " within \"#{@category.name}\" category"
                       end

    begin
      message = if total_found == 0
                  "Hey, looks like someone did a search for \"#{@searched_term}\"#{category_message} and nothing was found :( . Maybe try to tweak the search a little?"
                elsif total_found < 20
                  "Nice! Someone searched for \"#{@searched_term}\"#{category_message} and we found #{total_found} products for him/her!"
                else
                  "Whoa! A search has been submitted for \"#{@searched_term}\"#{category_message} and we found #{total_found} products! Amazing!"
                end
      $twitterClient.update(message)
    rescue StandardError
      # In case we get an error to tweet, thats fine, just skip it.
    end
  end
end
