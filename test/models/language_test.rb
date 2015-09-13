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

require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  test 'to_liquid' do
    hash = languages(:en).to_liquid

    assert hash.key? 'locale'
    assert hash.key? 'name'
    assert hash.key? 'image_src'
    assert hash.key? 'href'
  end

  test 'update appears' do
    lang = languages(:en)
    lang.appears_in_web = true
    lang.appears_in_backoffice = false

    assert lang.save
    assert !lang.appears_in_web
  end

  test 'valid_locale?' do
    assert Language.locale_valid?('en')
    assert !Language.locale_valid?('EN')
    assert !Language.locale_valid?('ch1')
  end
end
