require 'test_helper'

class ShoppingCartProductTest < ActiveSupport::TestCase
  test 'should to_liquid' do
    hash = shopping_carts_products(:scp_camera).to_liquid

    assert hash.key? 'product'
    assert hash.key? 'quantity'
    assert hash.key? 'retail_price'
  end
end
