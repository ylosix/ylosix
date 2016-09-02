# == Schema Information
#
# Table name: categories
#
#  created_at                     :datetime         not null
#  description_translations       :hstore           default({}), not null
#  enabled                        :boolean          default(FALSE)
#  href_translations              :hstore           default({}), not null
#  id                             :integer          not null, primary key
#  image_content_type             :string
#  image_file_name                :string
#  image_file_size                :integer
#  image_updated_at               :datetime
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

module CategoriesHelper
end
