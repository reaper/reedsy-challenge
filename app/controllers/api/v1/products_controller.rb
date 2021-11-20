class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[show]

  # GET /api/v1/products
  def index
    @products = Product.all
    render json: @products
  end

  # GET /api/v1/products/1
  def show
    render json: @product
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end
end
