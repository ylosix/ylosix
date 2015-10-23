require 'test_helper'

class InitializeSlugTest < ActiveSupport::TestCase
  test 'should have slug without numbers' do
    p1 = Product.create!(name: 'test name')
    p1.product_translations.each do |translation|
      assert_equal(translation.slug, 'test-name')
    end

    p2 = Product.create!(name: 'test another name')
    p2.product_translations.each do |translation|
      assert_equal(translation.slug, 'test-another-name')
    end
  end

  test 'should have slug ending with 2' do
    p1 = Product.create!(name: 'test name')
    p1.product_translations.each do |translation|
      assert_equal(translation.slug, 'test-name')
    end

    p2 = Product.create!(name: 'test name')
    p2.product_translations.each do |translation|
      assert_equal(translation.slug, 'test-name_2')
    end
  end
end
