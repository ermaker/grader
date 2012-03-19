class Grader
  attr_accessor :path

  def valid_zip_filename?
    !!(File.basename(path) =~ /^\d{8}(\[\d+\])?.zip$/)
  end

  def yourid
    File.basename(path)[/(\d{8})/,1]
  end
end
