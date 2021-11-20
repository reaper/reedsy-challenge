class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[show update]

  # GET /api/v1/products
  def index
    @products = Product.all
    render json: @products
  end

  # GET /api/v1/products/1
  def show
    render json: @product
  end

  # PATCH/PUT /api/v1/products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(
      :price_cents
    )
  end
end
