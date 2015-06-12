# == Schema Information
#
# Table name: categories
#
#  id               :integer          not null, primary key
#  parent_id        :integer
#  name             :string
#  enabled          :boolean          default(FALSE)
#  appears_in_web   :boolean          default(TRUE)
#  meta_keywords    :string
#  meta_description :string
#  slug             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_categories_on_parent_id  (parent_id)
#  index_categories_on_slug       (slug)
#

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'set_defaults' do
    c = Category.new(name: 'potato with spaces')
    assert c.save
    assert !c.slug.blank?

    ct = CategoryTranslation.new(name: 'potato with spaces', locale: :en)
    c = Category.new(category_translations: [ct])
    assert c.save
    assert !c.slug.blank?
  end

  test 'get_parents_array' do
    array = Utils.get_parents_array(categories(:root))
    assert array.empty?

    array = Utils.get_parents_array(categories(:digital_cameras))
    assert array.length == 1
  end

  test 'to_liquid' do
    hash = categories(:digital_cameras).to_liquid

    assert hash.key? 'name'
    assert hash.key? 'href'
    assert hash.key? 'children'
  end
end
