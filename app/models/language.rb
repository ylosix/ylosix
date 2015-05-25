# == Schema Information
#
# Table name: languages
#
#  id                    :integer          not null, primary key
#  locale                :string
#  appears_in_backoffice :boolean          default(FALSE)
#  appears_in_web        :boolean          default(FALSE)
#  created_at            :datetime
#  updated_at            :datetime
#  flag_file_name        :string
#  flag_content_type     :string
#  flag_file_size        :integer
#  flag_updated_at       :datetime
#  name                  :string
#
# Indexes
#
#  index_languages_on_locale  (locale)
#

class Language < ActiveRecord::Base
  has_attached_file :flag, styles: { medium: '300x300>', thumb: '100x100>' }

  validates_attachment_content_type :flag, content_type: /\Aimage\/.*\Z/

  before_save :update_appears

  scope :in_backoffice, -> () { where(appears_in_backoffice: true) }
  scope :in_frontend, -> () { where(appears_in_web: true) }

  def to_liquid
    image_src = 'http://placehold.it/15x15'
    image_src = flag.url(:medium) if flag.file?

    {
        'locale' => locale,
        'name' => name,
        'image_src' => image_src,
        'href' => Rails.application.routes.url_helpers.change_locale_path(locale)
    }
  end

  private

  def update_appears
    self.appears_in_web = 0 unless appears_in_backoffice
  end
end
