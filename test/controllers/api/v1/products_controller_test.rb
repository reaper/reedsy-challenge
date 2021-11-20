require 'test_helper'

class Api::V1::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = create(:product)
  end

  test 'should get index' do
    get api_v1_products_url, as: :json
    assert_response :success
  end

  test 'should show product' do
    get api_v1_product_url(@product), as: :json
    assert_response :success
  end

  test 'should show product with attributes' do
    get api_v1_product_url(@product), as: :json
    body = JSON.parse(response.body)

    %w[code name price].each do |attr|
      assert_not_empty(body[attr])
    end
  end
end
