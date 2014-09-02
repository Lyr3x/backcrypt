require 'bundler/setup'
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
        opt:unzip, "Unzip archive"
        opt:ver, "Backcrypt - version 0.1.1"
    end

# Unzip archive
def unzip_file (file, destination)
    Zip::File.open(file) do |zip_file|
        zip_file.each do |f|
            f_path = File.join(destination, f.name)
            FileUtils.mkdir_p(File.dirname(f_path))
            f.extract(f_path) 
        end
    end
end

if opts[:unzip] == true
    unzip_file(config["zipfile_name"], config["unzip_directory"])
end

# Program version output via flag
if opts[:ver] == true
        puts "Backcrypt - version 0.1.1"
end 

# Configuration
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

#Creating archive
Zip::File.open(config["zipfile_name"], Zip::File::CREATE) do |zipfile|
    Dir[File.join(config["directory"], '**', '**')].each do |file|
      zipfile.add(file.sub(config["directory"], ''), file)
    end
end
