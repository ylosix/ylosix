# == Schema Information
#
# Table name: languages
#
#  id                    :integer          not null, primary key
#  code                  :string
#  appears_in_backoffice :boolean
#  appears_in_web        :boolean
#  created_at            :datetime
#  updated_at            :datetime
#  flag_file_name        :string
#  flag_content_type     :string
#  flag_file_size        :integer
#  flag_updated_at       :datetime
#

class Language < ActiveRecord::Base
  has_attached_file :flag, :styles => {
                             :medium => '300x300>',
                             :thumb => '100x100>' }
  validates_attachment_content_type :flag, :content_type => /\Aimage\/.*\Z/
end
