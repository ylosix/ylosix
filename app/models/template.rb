# == Schema Information
#
# Table name: templates
#
#  id         :integer          not null, primary key
#  name       :string
#  path       :string
#  enabled    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Template < ActiveRecord::Base
  attr_accessor :home_index

  before_save :set_only_one_template_active

  def ok?(file_name)
    file_path = File.join(Rails.root, path, file_name)
    File.exist?(file_path)
  end

  def reads_file(file_name)
    file_path = File.join(Rails.root, path, file_name)

    content = ''
    content = File.read(file_path) if File.exist?(file_path)

    content
  end

  def writes_file(file_name, content)
    file_path = File.join(Rails.root, path, file_name)

    File.open(file_path, 'w') do |f|
      f.write content
    end
  end

  private

  def set_only_one_template_active
    Template.where('id != ?', id).update_all(enabled: false) if enabled
  end
end
