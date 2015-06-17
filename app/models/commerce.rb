# == Schema Information
#
# Table name: commerces
#
#  billing_address   :hstore
#  created_at        :datetime         not null
#  default           :boolean
#  http              :string
#  id                :integer          not null, primary key
#  logo_content_type :string
#  logo_file_name    :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  meta_description  :string
#  meta_keywords     :string
#  name              :string
#  template_id       :integer
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_commerces_on_template_id  (template_id)
#

class Commerce < ActiveRecord::Base
  belongs_to :template

  has_attached_file :logo, styles: {original: '300x100'}
  validates_attachment_content_type :logo, content_type: %r{\Aimage/.*\Z}
end
