class DepartmentsController < ApplicationController
  def show
    @department = Department.includes(:categories).find(params[:id])
  end
end
