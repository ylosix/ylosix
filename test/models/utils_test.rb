require 'test_helper'

class UtilsTest < ActiveSupport::TestCase
  def setup
    FileUtils.mkdir_p 'tmp/templates/test/snippets'
    File.open('tmp/templates/test/home_index.html', 'w') do |f|
      f.write '<h1>hello world</h1>'
    end

    File.open('tmp/templates/test/snippets/header.html', 'w') do |f|
      f.write '<h1>hello world</h1>'
    end

    object = templates(:test_template)
    object.enabled = true
    object.save
  end

  test 'zip and unzip' do
    object = templates(:test_template)
    zip_file = Utils.zip_folder(object.absolute_path)

    assert File.exist? zip_file

    output_folder = 'tmp/test_unzip'

    Utils.zip_extract(output_folder, zip_file)
  end
end
