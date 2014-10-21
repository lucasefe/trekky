require 'pathname'
require_relative 'data'
require_relative 'haml_source'
require_relative 'sass_source'
require_relative 'static_source'

class Trekky
  class Context

    attr_reader :source_dir

    def initialize(source_dir)
      @source_dir = Pathname.new(source_dir).expand_path
    end

    def each_source
      files[:sources].each do |path|
        yield build_source(path)
      end
    end

    def partials
      files[:partials]
    end

    def layouts
      files[:layouts]
    end

    def find_partial(name)
      if partial = partials.find { |path| path == (source_dir + name) }
        build_source(partial)
      end
    end

    def find_layout(name)
      layout = layouts.find do |path| 
        layout_path = source_dir + "layouts/#{name}"
        path == layout_path
      end

      if layout
        build_source(layout)
      end
    end

    def data
      @data ||= Data.new(data_path)
    end

    def layout
      if path = layouts.first
        build_source(path)
      end
    end

    private

    def files
      @files ||= find_files
    end

    def find_files
      all_files = { layouts: [], partials: [], sources: [] }

      paths.inject(all_files) do |hash, path|
        unless path.directory?
          if path.to_s.include?("#{source_dir}/layouts")
            hash[:layouts].push(path)
          elsif path.basename.to_s[0] == '_'
            hash[:partials].push(path)
          else
            hash[:sources].push(path)
          end
        end
        hash
      end
    end

    def paths
      Pathname.glob(source_dir + "**/*")
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

    def data_path
      File.join(Dir.pwd, 'data')
    end

  end
end
