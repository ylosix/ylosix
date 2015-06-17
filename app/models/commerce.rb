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
  attr_accessor :root_href

  belongs_to :template

  has_attached_file :logo, styles: {original: '300x100'}
  validates_attachment_content_type :logo, content_type: %r{\Aimage/.*\Z}

  def to_liquid
    image_src = 'http://placehold.it/300x100'
    image_src = logo.url(:original) if logo?

    {
        'http' => http,
        'image_src' => image_src,
        'meta_description' => meta_description,
        'meta_keywords' => meta_keywords,
        'name' => name,
        'root_href' => root_href,
        'template' => template
    }
  end
end
