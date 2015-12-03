require 'test_helper'

class InitializeSlugTest < ActiveSupport::TestCase
  test 'product should have slug without numbers' do
    p1 = Product.create!(product_translations_attributes:
                             [{locale: :en, name: 'test name'}])

    assert p1.product_translations.size > 0
    p1.product_translations.each do |translation|
      assert_equal(translation.slug, 'test-name')
    end

    p2 = Product.create!(product_translations_attributes:
                             [{locale: :en, name: 'test another name'}])
    assert p2.product_translations.size > 0
    p2.product_translations.each do |translation|
      assert_equal(translation.slug, 'test-another-name')
    end
  end

  test 'product should have slug ending with 1' do
    p1 = Product.create!(product_translations_attributes:
                             [{locale: :en, name: 'test name'}])
    assert p1.product_translations.size > 0
    p1.product_translations.each do |translation|
      assert_equal(translation.slug, 'test-name')
    end

    p2 = Product.create!(product_translations_attributes:
                             [{locale: :en, name: 'test name'}])
    assert p2.product_translations.size > 0
    p2.product_translations.each do |translation|
      assert_equal(translation.slug, 'test-name_1')
    end

    p2.save
    p2.product_translations.each do |translation|
      assert_equal(translation.slug, 'test-name_1')
    end
  end

  test 'category should have slug without numbers' do
    c1 = Category.create!(category_translations_attributes:
                             [{locale: :en, name: 'test name'}])
    assert c1.category_translations.size > 0
    c1.category_translations.each do |translation|
      assert_equal(translation.slug, 'test-name')
    end

    c2 = Category.create!(category_translations_attributes:
                              [{locale: :en, name: 'test another name'}])
    assert c2.category_translations.size > 0
    c2.category_translations.each do |translation|
      assert_equal(translation.slug, 'test-another-name')
    end
  end

  test 'category should have slug ending with 1' do
    c1 = Category.create!(category_translations_attributes:
                              [{locale: :en, name: 'test name'}])
    assert c1.category_translations.size > 0
    c1.category_translations.each do |translation|
      assert_equal(translation.slug, 'test-name')
    end

    c2 = Category.create!(category_translations_attributes:
                              [{locale: :en, name: 'test name'}])
    assert c2.category_translations.size > 0
    c2.category_translations.each do |translation|
      assert_equal(translation.slug, 'test-name_1')
    end
  end

  test 'product should have slug ending with 1 if have the same name with a category' do
    c1 = Category.create!(category_translations_attributes:
                              [{locale: :en, name: 'test name'}])
    assert c1.category_translations.size > 0

    p1 = Product.create!(product_translations_attributes:
                             [{locale: :en, name: 'test name'}])
    assert p1.product_translations.size > 0
    p1.product_translations.each do |translation|
      assert_equal(translation.slug, 'test-name_1')
    end
  end
end
