require 'rubygems'
require 'zip/zip'
require 'open3'
require 'tmpdir'

class Grader
  attr_accessor :path

  def exact_zipfilename?
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

  def file(filepath)
    Zip::ZipFile.open(path) {|zip_file| zip_file.read(filepath)}
  end

  def exact_pyfilename?
    files.include?("#{yourid}.py")
  end

  def exact_wldfilename?
    files.include?("#{yourid}.wld")
  end

  def exact_docfilename?
    files.any? {|fn| fn =~ /^#{yourid}\.docx?$/}
  end

  def pyfilename
    return "#{yourid}.py" if exact_pyfilename?
    pyfiles = files.select {|fn| File.basename(fn) == "#{yourid}.py"}
    unless pyfiles.empty?
      return pyfiles.first if pyfiles.one?
      raise 'Many possible files.'
    end
    pyfiles = files.select {|fn| File.extname(fn) == '.py'}
    return pyfiles.first if pyfiles.one?
    pyfiles = files.select {|fn| File.basename(fn) =~ /#{yourid}.*\.py$/}
    return pyfiles.first if pyfiles.one?
    raise 'Undecidable situation.'
  end

  def wldfilename
    files.find {|fn| File.basename(fn) == "#{yourid}.wld"}
  end

  def docfilename
    files.find {|fn| File.basename(fn) =~ /^#{yourid}\.docx?$/}
  end

  def run wldfilename, *options
    _wldfilename = wldfilename
    output = Dir.mktmpdir do |tmpdir|
      code = file(pyfilename)
      if not options.empty? and options.first[:in] == :zip
        _wldfilename = File.join(tmpdir, File.basename(wldfilename))
        File.open(_wldfilename, 'w') {|f| f << file(wldfilename)}
      end
      code.gsub!(/load_world\s*\(.*\)/, "load_world('#{_wldfilename}')")
      Open3.popen3("python") do |i,o,e,t|
        i.puts code
        i.puts 'import cs1robots'
        i.puts 'print hubo.on_beeper() and ami.on_beeper() and len(cs1robots._world.beepers) == 1'
        i.puts 'cs1robots._scene.close()'
        i.puts 'exit()'
        i.close
        e.read + o.read
      end
    end
    !!(output =~ /True/)
  end
end
