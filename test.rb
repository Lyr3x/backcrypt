require 'rubygems'
require 'trollop'

opts = Trollop::options do
  opt :no, "BEST_COMPRESSION"
  opt :best, "NO_COMPRESSION"

end

if opts[:no] == true
        x="NO_COMPRESSION"
        puts x
        
    end 


