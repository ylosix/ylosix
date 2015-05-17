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

  # Usage:
  #   directoryToZip = "/tmp/input"
  #   outputFile = "/tmp/out.zip"
  #   Utils.zip_folder(directoryToZip, outputFile)
  def self.zip_folder(input_dir)
    require 'zip'

    zip_file = "/tmp/#{Time.now.to_i}.zip"

    entries = Dir.entries(input_dir)
    entries.delete('.')
    entries.delete('..')

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
      puts "Deflating #{disk_file_path}"
      if File.directory?(disk_file_path)
        io.mkdir(zip_file_path)
        subdir = Dir.entries(zip_file_path)
        subdir.delete('.')
        subdir.delete('..')

        write_entries(input_dir, subdir, zip_file_path, io)
      else
        io.get_output_stream(zip_file_path) { |f| f.puts(File.open(disk_file_path, 'rb').read) }
      end
    end
  end
end
