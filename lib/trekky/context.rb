require_relative 'haml_source'
require_relative 'static_source'
require_relative 'sass_source'

class Trekky
  class Context

    attr_reader :source_dir

    def initialize(source_dir)
      @source_dir = source_dir
      @files = { layouts: [], partials: [], sources: [] }
      build
    end

    def sources
      @files[:sources]
    end

    def partials
      @files[:partials]
    end

    def layouts
      @files[:layouts]
    end

    def find_partial(name)
      partials.find {|p| p.path == File.join(source_dir, name)}
    end

    private

    def build
      Dir.glob(File.join(source_dir, "**/*")).each do |path|

        next if File.directory?(path)

        source = build_source(path)

        if path.include?("#{source_dir}/layouts")
          @files[:layouts] << source
          next
        end

        if File.basename(path)[0] == '_'
          @files[:partials] << source
          next
        end

        @files[:sources] << source
      end
    end

    def build_source(path)
      type = File.extname(path)[1..-1].intern
      find_source_class(type).new(self, path)
    end

    def find_source_class(type)
      types[type] || StaticSource
    end

    def types
      { sass: SassSource, haml: HamlSource }
    end

  end
end
