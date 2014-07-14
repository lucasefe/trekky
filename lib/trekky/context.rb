require 'trekky/source'

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

    private

    def build
      Dir.glob(File.join(source_dir, "**/*")).each do |path|
        
        next if File.directory?(path)
        source = Source.new(self, path)

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

  end
end
