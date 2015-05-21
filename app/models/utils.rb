class Utils
  def self.get_parents_array(object)
    array = []

    parent = object.parent
    until parent.nil?
      array << parent
      parent = parent.parent
    end

    array.reverse
  end

  def self.zip_extract(output_dir, file)
    FileUtils.mkdir_p output_dir

    require 'zip'
    zf = Zip::File.new(file)
    zf.each_with_index do |entry, index|
      puts "entry #{index} is #{entry.name}, size = #{entry.size}, compressed size = #{entry.compressed_size}"
      # use zf.get_input_stream(entry) to get a ZipInputStream for the entry
      # entry can be the ZipEntry object or any object which has a to_s method that
      # returns the name of the entry.

      file_out_put = File.join(output_dir, entry.name)
      File.open(file_out_put, 'w') do |f|
        f.write zf.get_input_stream(entry).read
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
