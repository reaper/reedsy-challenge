require 'test_helper'

class Api::V1::ProductsControllerComputePriceTest < ActionDispatch::IntegrationTest
  setup do
    10.times.each do
      create(:product)
    end
  end

  test 'fails to compute price without product ids' do
    get compute_price_api_v1_products_url, as: :json
    assert_response :bad_request
  end

  test 'fails to compute price with bad product id' do
    get compute_price_api_v1_products_url(codes: ['BAAAAAAAD']), as: :json
    assert_response :not_found
  end

  test 'should be able to compute the price of selected products' do
    products = 5.times.map { Product.all.sample }
    get compute_price_api_v1_products_url(codes: products.map(&:code)), as: :json
    assert_response :success

    body = JSON.parse(response.body)
    %w[codes_with_count price_cents price].each do |attr|
      assert(body.key?(attr))
    end

    assert(products.all? { |product| body['codes_with_count'].keys.include?(product.code) })
    assert_equal(body['price_cents'], products.map(&:price_cents).sum)
  end
end
