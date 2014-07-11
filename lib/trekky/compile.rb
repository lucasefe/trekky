require 'haml'
require 'sass'

module Trekky
  class Compile

    attr_reader :source_dir, :target_dir

    def initialize(source_dir, target_dir)
      @source_dir = source_dir
      @target_dir = target_dir
    end

    def run
      all_files.each do |source|
        case File.extname(source)
        when '.haml' then haml(source)
        when '.sass' then sass(source)
        end
      end
    end

    private

    def haml(source)
      prepare(source, 'haml', 'html') do |f|
        f.write Haml::Engine.new(File.read(source)).render
      end
    end

    def sass(source)
      prepare(source, 'sass', 'css') do |f|
        f.write Sass::Engine.new(File.read(source), :syntax => :sass).render
      end
    end

    def all_files
      Dir.glob(File.join(source_dir, "**/*"))
    end

    def prepare(source, type, extension)
      target = source.gsub(source_dir, target_dir).gsub(/\.#{type}/, '')
      if File.extname(target) == ''
        target += ".#{extension}"
      end
      puts "Compiling #{source} to #{target} with #{type.upcase}"
      File.open(target, 'w') do |f|
        yield(f)
      end
    end

  end
end
