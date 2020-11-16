class DepartmentsController < ApplicationController
  def show
    @filter = params[:filter]
    @department = Department.includes(categories: [:products]).find(params[:id])
    @products = if @filter == "new"
                  @department.products
                             .where(created_at: (Date.today - 3.days)..Date.today + 1)
                             .page(params[:page]).order(:name)
                elsif @filter == "recent"
                  @department.products
                             .where(updated_at: (Date.today - 3.days)..Date.today + 1)
                             .page(params[:page]).order(:name)
                else
                  @department.products.page(params[:page]).order(:name)
                end
  end
end
