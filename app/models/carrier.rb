# == Schema Information
#
# Table name: carriers
#
#  created_at         :datetime         not null
#  delay              :string
#  enabled            :boolean          default(FALSE), not null
#  free_carrier       :boolean          default(FALSE), not null
#  id                 :integer          not null, primary key
#  image_content_type :string
#  image_file_name    :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  name               :string
#  priority           :integer          default(1), not null
#  updated_at         :datetime         not null
#

class Carrier < ActiveRecord::Base
  translates :name, :delay

  has_many :carrier_translations
  accepts_nested_attributes_for :carrier_translations

  has_attached_file :image, styles: { original: '25x25' }
  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\Z}
end
