require 'test_helper'

class ShoppingCartProductTest < ActiveSupport::TestCase
  test 'should to_liquid' do
    hash = shopping_carts_products(:scp_camera).to_liquid

    assert hash.key? 'product'
    assert hash.key? 'quantity'
    assert hash.key? 'retail_price'
  end

  test 'to_shopping_order' do
    scp = shopping_carts_products(:scp_camera)
    sop = scp.to_shopping_order

    assert sop.quantity = scp.quantity
    assert sop.product_id = scp.product_id
    assert sop.retail_price = scp.product.retail_price
    assert sop.retail_price_pre_tax = scp.product.retail_price_pre_tax
    assert sop.tax_rate = scp.product.tax.rate unless scp.product.tax.nil?
  end
end
