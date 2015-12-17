# == Schema Information
#
# Table name: links
#
#  class_name :string           not null
#  created_at :datetime         not null
#  enabled    :boolean          not null
#  id         :integer          not null, primary key
#  locale     :string           not null
#  object_id  :integer          not null
#  slug       :string           not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_links_on_class_name  (class_name)
#  index_links_on_object_id   (object_id)
#  index_links_on_slug        (slug)
#

class Link < ActiveRecord::Base
  validates_uniqueness_of :slug
end
