require 'test_helper'

class InitializeSlugTest < ActiveSupport::TestCase
  test 'product should have slug without numbers' do
    p1 = Product.create!(name: 'test name')
    p1.product_translations.each do |translation|
      assert_equal(translation.slug, 'test-name')
    end

    p2 = Product.create!(name: 'test another name')
    p2.product_translations.each do |translation|
      assert_equal(translation.slug, 'test-another-name')
    end
  end

  test 'product should have slug ending with 2' do
    p1 = Product.create!(name: 'test name')
    p1.product_translations.each do |translation|
      assert_equal(translation.slug, 'test-name')
    end

    p2 = Product.create!(name: 'test name')
    p2.product_translations.each do |translation|
      assert_equal(translation.slug, 'test-name_2')
    end
  end

  test 'category should have slug without numbers' do
    c1 = Category.create!(name: 'test name')
    c1.category_translations.each do |translation|
      assert_equal(translation.slug, 'test-name')
    end

    c2 = Category.create!(name: 'test another name')
    c2.category_translations.each do |translation|
      assert_equal(translation.slug, 'test-another-name')
    end
  end

  test 'category should have slug ending with 2' do
    c1 = Category.create!(name: 'test name')
    c1.category_translations.each do |translation|
      assert_equal(translation.slug, 'test-name')
    end

    c2 = Category.create!(name: 'test name')
    c2.category_translations.each do |translation|
      assert_equal(translation.slug, 'test-name_2')
    end
  end

  test 'product should have slug ending with 2 if have the same name with a category' do
    Category.create!(name: 'test name')

    p1 = Product.create!(name: 'test name')
    p1.product_translations.each do |translation|
      assert_equal(translation.slug, 'test-name_2')
    end
  end

  test 'category should have slug ending with 2 if have the same name with a product' do
    Product.create!(name: 'test name')

    c1 = Category.create!(name: 'test name')
    c1.category_translations.each do |translation|
      assert_equal(translation.slug, 'test-name_2')
    end
  end
end
