# == Schema Information
#
# Table name: languages
#
#  appears_in_backoffice :boolean          default(FALSE)
#  appears_in_web        :boolean          default(FALSE)
#  created_at            :datetime
#  default               :boolean          default(FALSE)
#  flag_content_type     :string
#  flag_file_name        :string
#  flag_file_size        :integer
#  flag_updated_at       :datetime
#  id                    :integer          not null, primary key
#  locale                :string
#  name                  :string
#  updated_at            :datetime
#
# Indexes
#
#  index_languages_on_locale  (locale)
#

class Language < ActiveRecord::Base
  has_attached_file :flag, styles: { original: '25x25' }

  validates_attachment_content_type :flag, content_type: %r{\Aimage/.*\Z}

  before_save :update_appears

  scope :in_backoffice, -> () { where(appears_in_backoffice: true) }
  scope :in_frontend, -> () { where(appears_in_web: true) }

  def self.locale_valid?(locale)
    return false if locale.nil?

    language = Language.find_by(locale: locale, appears_in_web: true)
    !language.nil?
  end

  def to_liquid
    image_src = 'http://placehold.it/25x25'
    image_src = flag.url(:original) if flag?

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
