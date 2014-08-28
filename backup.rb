require 'rubygems'
require 'zip'
require 'json'
require 'trollop'
      
config = JSON.parse(File.read 'config.json')

# options = { :directory => config["directory"], 
#             :zipfile_name => config["zipfile_name"] }

# Execute flags for compression level
opts = Trollop::options do
        opt:no, "NO_COMPRESSION"
        opt:best, "BEST_COMPRESSION"
        opt:default, "DEFAULT_COMPRESSION"
        opt:ver, "Backcrypt - version 0.1.1"
    end

# Program version output via flag
if opts[:ver] == true
        puts "Backcrypt - version 0.1.1"
end 

#Archive configuration

Zip.setup do |c|
    # Overwrite files
    c.on_exists_proc = true
    # Overwrite existing .zip files
    c.continue_on_exists_proc = true
    # Abbility to store archives with non-english names
    c.unicode_names = true
    # Compression level: Best => possible options: DEFAULT, BEST, NO        
  if opts[:no] == true
        c.default_compression = Zlib::NO_COMPRESSION
        elsif opts[:best] == true
            c.default_compression = Zlib::BEST_COMPRESSION
        elsif opts[:default] == true
            c.default_compression = Zlib::DEFAULT_COMPRESSION
  end
end

Zip::File.open(config["zipfile_name"], Zip::File::CREATE) do |zipfile|
    Dir[File.join(config["directory"], '**', '**')].each do |file|
      zipfile.add(file.sub(config["directory"], ''), file)
    end
end
