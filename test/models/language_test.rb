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

    lang.save
    assert !lang.appears_in_web
  end
end
