class DepartmentsController < ApplicationController
  def show
    @department = Department.includes(:categories).find(params[:id])
    @products = []
    @department.categories.each do |category|
      category.products.each do |product|
        @products << product
      end
    end
  end
end
