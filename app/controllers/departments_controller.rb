class DepartmentsController < ApplicationController
  def show
    @department = Department.includes(categories: [:products]).find(params[:id])
    @products = @department.products.page(params[:page]).order(:name)
  end
end
