require 'fileutils'
require_relative 'trekky/context'

class Trekky

  def initialize(source_dir)
    @context = Context.new(source_dir)
  end

  def render_to(target_dir)
    @context.sources.each do |source|
      path = target_path(target_dir, source)
      output = source.render
      output = source.render_errors unless source.valid?
      STDOUT.puts "Writing #{source.path} to #{path}"
      write(output, path)
    end
  end

  private

  def target_path(target_dir, source)
    path = File.join(target_dir, source.path.gsub(@context.source_dir, ''))
    if type = source.type
      path.gsub(/\.#{type}/, '')
    else
      path
    end
  end

  def write(output, path)
    FileUtils.mkdir_p(File.dirname(path))
    File.open(path, "wb") {|f| f.write(output) }
  end

end
