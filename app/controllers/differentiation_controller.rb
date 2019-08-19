class DifferentiationController < ApplicationController
  def show
    coefficients = params[:coefficients].split('/')
    result = DifferentiationService.new(coefficients).call
    if result.success?
      render json: result.data
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end
end
