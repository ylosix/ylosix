class Utils
  def self.get_error_title(messages)
    return '' if messages.empty?

    I18n.t('errors.messages.not_saved', count: messages.count, resource: 'the form')
  end

  def self.append_debug_variables(admin_user, variables, html_content)
    if !admin_user.nil? && admin_user.debug_variables
      content_hash_variables = Utils.pretty_json_template_variables(variables)
      html_code = JSON.pretty_generate(content_hash_variables)
      html_content += "<br /><pre><code>#{html_code}</code></pre>"
    end

    html_content
  end

  def self.replace_regex_include(variables, template, content)
    regex_include_snippet = /{{\s*include\s+(?<file>[^}\s]+)\s*}}/

    match_data = regex_include_snippet.match(content)
    if match_data
      snippet_content = template.reads_file(match_data[:file])

      new_content = content.gsub(match_data.to_s, snippet_content)
      content = Utils.replace_regex_include(variables, template, new_content)
    end

    content
  end

  def self.pretty_json_template_variables(variables)
    content_hash_variables = {}
    variables.each do |k, v|
      if v.class.name.include? 'ActiveRecord'
        content_hash_variables[k] = []

        v.each do |v_elem|
          content_hash_variables[k] << v_elem.to_liquid
        end
      else
        content_hash_variables[k] = v.to_liquid
      end
    end

    content_hash_variables.as_json
  end

  def self.get_parents_array(object)
    array = []

    parent = object.parent
    until parent.nil?
      array << parent
      parent = parent.parent
    end

    array.reverse
  end

  def self.array_translations(model, attributes)
    translations = []

    Language.in_backoffice.each do |lang|
      attributes[:locale] = lang.locale
      ct = model.find_by(attributes)
      ct = model.new(attributes) if ct.nil?

      translations << ct
    end

    translations
  end

  def self.zip_extract(output_dir, file)
    FileUtils.mkdir_p output_dir

    require 'zip'
    zf = Zip::File.new(file)
    zf.each_with_index do |entry, _|
      # puts "entry #{index} is #{entry.name}, size = #{entry.size}, compressed size = #{entry.compressed_size}"
      # use zf.get_input_stream(entry) to get a ZipInputStream for the entry
      # entry can be the ZipEntry object or any object which has a to_s method that
      # returns the name of the entry.

      file_output = File.join(output_dir, entry.name)
      if entry.file?
        FileUtils.mkdir_p Pathname.new(file_output).dirname

        File.open(file_output, 'wb') do |f|
          f.write zf.get_input_stream(entry).read
        end
      else
        FileUtils.mkdir_p file_output
      end
    end
  end

  # Usage:
  #   directoryToZip = "/tmp/input"
  #   outputFile = "/tmp/out.zip"
  #   Utils.zip_folder(directoryToZip, outputFile)
  def self.zip_folder(input_dir)
    zip_file = "/tmp/#{Time.now.to_i}.zip"

    File.delete(zip_file) if File.exist? zip_file
    entries = Dir.entries(input_dir)
    entries.delete('.')
    entries.delete('..')

    require 'zip'
    io = Zip::File.open(zip_file, Zip::File::CREATE)

    write_entries(input_dir, entries, '', io)
    io.close

    zip_file
  end

  # A helper method to make the recursion work.
  def self.write_entries(input_dir, entries, path, io)
    entries.each do |e|
      zip_file_path = path == '' ? e : File.join(path, e)
      disk_file_path = File.join(input_dir, zip_file_path)

      if File.directory?(disk_file_path)
        io.mkdir(zip_file_path)
        subdir = Dir.entries(disk_file_path)
        subdir.delete('.')
        subdir.delete('..')

        write_entries(input_dir, subdir, zip_file_path, io)
      else
        io.get_output_stream(zip_file_path) { |f| f.puts(File.open(disk_file_path, 'rb').read) }
      end
    end
  end
end
