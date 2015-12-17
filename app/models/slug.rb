# == Schema Information
#
# Table name: slugs
#
#  class_name :string           not null
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  locale     :string           not null
#  object_id  :integer          not null
#  slug       :string           not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_slugs_on_class_name  (class_name)
#  index_slugs_on_object_id   (object_id)
#  index_slugs_on_slug        (slug)
#

class Slug < ActiveRecord::Base
  validates_uniqueness_of :slug
end
