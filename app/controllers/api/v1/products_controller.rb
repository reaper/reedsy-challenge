class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[show update]

  # GET /api/v1/products
  def index
    @products = Product.all
    render json: @products
  end

  # GET /api/v1/products/code
  def show
    render json: @product
  end

  # PATCH/PUT /api/v1/products/code
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # GET /api/v1/products/compute_price
  def compute_price
    unless params[:codes].present?
      render json: :no_product_codes, status: :bad_request
      return
    end

    begin
      codes_with_count = params[:codes].tally
      price_cents = codes_with_count.sum do |code, count|
        product = Product.find_by!(code: code)
        products_count = count
        product_price_cents = product.price_cents

        # apply discounts
        if product.discount.present?
          product.discount.each do |key, options|
            case key
            when '2_for_1'
              products_count -= 1 if count >= 2
            when 'percentage'
              product_price_cents *= (1 - options['amount']) if count >= options['buy_at_least']
            end
          end
        end

        product_price_cents * products_count
      end
    rescue ActiveRecord::RecordNotFound
      render json: :product_not_found, status: :not_found
      return
    end

    products_price = ProductsPrice.new(
      codes_with_count: codes_with_count,
      price_cents: price_cents
    )

    render json: products_price
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find_by!(code: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(
      :price_cents
    )
  end
end
