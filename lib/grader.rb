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

  def pyfilename
    files.find {|fn| File.basename(fn) == "#{yourid}.py"}
  end

  def wldfilename
    files.find {|fn| File.basename(fn) == "#{yourid}.wld"}
  end

  def docfilename
    files.find {|fn| File.basename(fn) =~ /^#{yourid}\.docx?$/}
  end

  def run wldfilename
    code = file(pyfilename)
    code.gsub!(/load_world\s*\(.*\)/, "load_world('#{wldfilename}')")
    output = Dir.mktmpdir do |tmpdir|
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
