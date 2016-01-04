# == Schema Information
#
# Table name: categories
#
#  created_at                     :datetime         not null
#  description_translations       :hstore           default({}), not null
#  enabled                        :boolean          default(FALSE)
#  href_translations              :hstore           default({}), not null
#  id                             :integer          not null, primary key
#  meta_tags_translations         :hstore           default({}), not null
#  name_translations              :hstore           default({}), not null
#  parent_id                      :integer
#  priority                       :integer          default(1), not null
#  reference_code                 :string
#  short_description_translations :hstore           default({}), not null
#  show_action_name               :string
#  slug_translations              :hstore           default({}), not null
#  updated_at                     :datetime         not null
#  visible                        :boolean          default(TRUE)
#
# Indexes
#
#  index_categories_on_enabled         (enabled)
#  index_categories_on_parent_id       (parent_id)
#  index_categories_on_reference_code  (reference_code)
#

require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = categories(:digital_cameras)
    @category.save
  end

  test 'should get index' do
    get :index, format: 'json'
    assert_response :success
  end

  test 'should get show' do
    get :show, category_id: @category.slug
    assert_response :success

    get :show, category_id: @category.id
    assert_response :success

    # TODO: check when id nil return 404 not found
  end

  test 'should get tag' do
    tag = tags(:cameras)

    get :tags, category_id: @category.id, slug_tags: tag.id
    assert_response :success
  end

  test 'shold get notfound' do
    get :show, category_id: 'not-found'
    assert_response :not_found
  end
end
