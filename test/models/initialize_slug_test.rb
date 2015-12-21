require 'test_helper'

class InitializeSlugTest < ActiveSupport::TestCase
  test 'product should have slug without numbers' do
    p1 = Product.create!(name_translations: { en: 'test name'})
    assert p1.slug_translations.size > 0

    p1.slug_translations.each do |_k, v|
      assert_equal('test-name', v)
    end

    p2 = Product.create!(name_translations: { en: 'test another name'})
    assert p2.slug_translations.size > 0

    p2.slug_translations.each do |_k, v|
      assert_equal('test-another-name', v)
    end
  end

  test 'product should have slug ending with 1' do
    p1 = Product.create!(name_translations: { en: 'test name'})
    assert p1.slug_translations.size > 0
    p1.slug_translations.each do |_k, v|
      assert_equal('test-name', v)
    end

    p2 = Product.create!(name_translations: { en: 'test name'})
    assert p2.slug_translations.size > 0
    p2.slug_translations.each do |_k, v|
      assert_equal('test-name_1', v)
    end

    p2.save
    p2.slug_translations.each do |_k, v|
      assert_equal('test-name_1', v)
    end
  end

  test 'category should have slug without numbers' do
    c1 = Category.create!(name_translations: { en: 'test name'})
    assert c1.slug_translations.size > 0

    c1.slug_translations.each do |_k, v|
      assert_equal('test-name', v)
    end

    c2 = Category.create!(name_translations: { en: 'test another name'})
    assert c2.slug_translations.size > 0

    c2.slug_translations.each do |_k, v|
      assert_equal('test-another-name', v)
    end
  end

  test 'category should have slug ending with 1' do
    c1 = Category.create!(name_translations: { en: 'test name'})
    assert c1.slug_translations.size > 0
    c1.slug_translations.each do |_k, v|
      assert_equal('test-name', v)
    end

    c2 = Category.create!(name_translations: { en: 'test name'})
    assert c2.slug_translations.size > 0
    c2.slug_translations.each do |_k, v|
      assert_equal('test-name_1', v)
    end

    c2.save
    c2.slug_translations.each do |_k, v|
      assert_equal('test-name_1', v)
    end
  end

  test 'product should have slug ending with 1 if have the same name with a category' do
    c1 = Category.create!(name_translations: { en: 'test name'})
    assert c1.slug_translations.size > 0

    p1 = Product.create!(name_translations: { en: 'test name'})
    assert p1.slug_translations.size > 0

    p1.slug_translations.each do |_k, v|
      assert_equal('test-name_1', v)
    end
  end
end
