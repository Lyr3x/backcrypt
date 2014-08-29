require 'rubygems'
require 'trollop'
require	'json'
require	'zip'

config = JSON.parse(File.read 'config.json')

Zip::File.open(config["zipfile_name"]) do |zip_file|
  # Handle entries one by one
  zip_file.each do |entry|
    # Extract to file/directory/symlink
    puts "Extracting #{entry.name}"
    entry.extract(dest_file)

    # Read into memory
    content = entry.get_input_stream.read
  end

  # Find specific entry
  #entry = zip_file.glob('*.csv').first
  #puts entry.get_input_stream.read
end


