require 'rubygems'
require 'zip/zip'

class Grader
  attr_accessor :path

  def valid_zip_filename?
    !!(File.basename(path) =~ /^\d{8}(\[\d+\])?.zip$/)
  end

  def yourid
    File.basename(path)[/(\d{8})/,1]
  end

  def files
    Zip::ZipFile.open(path) do |zip_file|
      zip_file.map {|file| file.name }
    end
  end

  def pyfilename
    files.find {|fn| File.basename(fn) == "#{yourid}.py"}
  end
end
