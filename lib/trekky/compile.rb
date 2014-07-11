require 'trekky/haml_parser'
require 'trekky/sass_parser'

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
      HamlParser.new(source, source_dir, target_dir).render
    end

    def sass(source)
      SassParser.new(source, source_dir, target_dir).render
    end

    def all_files
      Dir.glob(File.join(source_dir, "**/*"))
    end

  end
end
