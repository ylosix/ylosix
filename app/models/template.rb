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

  def public_path
    return nil if path.blank?

    path.gsub('/public', '')
  end

  def self.active_template(current_admin_user)
    if !current_admin_user.nil? && !current_admin_user.debug_template.nil?
      template = current_admin_user.debug_template
    else
      template = Template.find_by(enabled: true)
    end

    template
  end

  def ok?(file_name)
    file_path = File.join(absolute_path, file_name)
    File.exist?(file_path)
  end

  def absolute_path
    File.join(Rails.root, path)
  end

  def files
    local_files = {}

    files = Dir.entries(absolute_path)
    files.each do |file_name|
      next if file_name == '.' || file_name == '..' || File.directory?(File.join(absolute_path, file_name))

      name = file_name.split('.')[0]
      local_files[name] = reads_file(file_name) unless name.blank?
    end

    local_files
  end

  def reads_file(file_name)
    file_path = File.join(absolute_path, file_name)

    content = "Error => File (#{file_path}) not found!!!"
    content = File.read(file_path) if ok?(file_name)

    content
  end

  def writes_files(params)
    files = Dir.entries(absolute_path)
    files.each do |file|
      next if file == '.' || file == '..'

      name = file.split('.')[0]
      writes_file(file, params[name]) if params.key? name
    end
  end

  def to_liquid
    {
        'name' => name,
        'path' => path,
        'public_path' => public_path,
        'enabled' => enabled
    }
  end

  private

  def writes_file(file_name, content)
    file_path = File.join(absolute_path, file_name)

    File.open(file_path, 'w') do |f|
      f.write content
    end
  end

  def set_only_one_template_active
    Template.where('id != ?', id).update_all(enabled: false) if enabled
  end
end
