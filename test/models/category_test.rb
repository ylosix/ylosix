# == Schema Information
#
# Table name: categories
#
#  created_at       :datetime         not null
#  enabled          :boolean          default(FALSE)
#  id               :integer          not null, primary key
#  meta_description :string
#  meta_keywords    :string
#  name             :string
#  parent_id        :integer
#  priority         :integer          default(1), not null
#  slug             :string
#  updated_at       :datetime         not null
#  visible          :boolean          default(TRUE)
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
