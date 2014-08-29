require 'rubygems'
require 'trollop'
require	'json'
require	'zip'

config = JSON.parse(File.read 'config.json')

def unzip_file (file, destination)
	Zip::File.open(file) do |zip_file|
		zip_file.each do |f|
			f_path = File.join(destination, f.name)
			FileUtils.mkdir_p(File.dirname(f_path))
			f.extract(f_path) 
		end
	end
end

unzip_file(config["zipfile_name"], config["directoryx"])


