# == Schema Information
#
# Table name: products
#
#  barcode                        :string
#  control_stock                  :boolean          default(FALSE)
#  created_at                     :datetime
#  depth                          :decimal(10, 6)   default(0.0), not null
#  description_translations       :hstore           default({}), not null
#  enabled                        :boolean          default(FALSE)
#  features_translations          :hstore           default({}), not null
#  height                         :decimal(10, 6)   default(0.0), not null
#  href_translations              :hstore           default({}), not null
#  id                             :integer          not null, primary key
#  image_content_type             :string
#  image_file_name                :string
#  image_file_size                :integer
#  image_updated_at               :datetime
#  meta_tags_translations         :hstore           default({}), not null
#  name_translations              :hstore           default({}), not null
#  publication_date               :datetime         not null
#  reference_code                 :string
#  retail_price                   :decimal(10, 2)   default(0.0), not null
#  retail_price_pre_tax           :decimal(10, 5)   default(0.0), not null
#  short_description_translations :hstore           default({}), not null
#  show_action_name               :string
#  slug_translations              :hstore           default({}), not null
#  stock                          :integer          default(0)
#  tax_id                         :integer
#  unpublication_date             :datetime
#  updated_at                     :datetime
#  visible                        :boolean          default(TRUE)
#  weight                         :decimal(10, 6)   default(0.0), not null
#  width                          :decimal(10, 6)   default(0.0), not null
#
# Indexes
#
#  index_products_on_enabled  (enabled)
#  index_products_on_tax_id   (tax_id)
#  index_products_on_visible  (visible)
#
# Foreign Keys
#
#  fk_rails_f5661f270e  (tax_id => taxes.id)
#

require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @product = products(:camera)
    @product.save
  end

  test 'should get show' do
    get :show, product_id: @product.id
    assert_response :success

    get :show, product_id: @product.slug
    assert_response :success
  end

  test 'should add to shopping cart' do
    login_customer

    get :add_to_shopping_cart, product_id: @product.id
    assert_response :redirect

    get :delete_from_shopping_cart, product_id: @product.id
    assert_response :redirect

    get :add_to_shopping_cart, product_id: @product.id
    assert_response :redirect

    object = products(:lens_canon)
    get :add_to_shopping_cart, product_id: object.id
    assert_response :redirect
  end

  test 'should add to shopping cart session' do
    get :add_to_shopping_cart, product_id: @product.id
    assert_response :redirect
  end
end
