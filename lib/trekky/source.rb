require 'trekky/haml_processor'
require 'trekky/null_processor'
require 'trekky/sass_processor'

class Trekky

  class Source

    def initialize(context, path)
      @path = path
      @context = context
    end

    def render(&block)
      processor.render(&block)
    end

    def processor
      @processor ||= find_processor.new(self)
    end
    
    def find_processor
      processors[type] || default_processor      
    end

    def path
      @path
    end

    def context
      @context
    end

    def type
      extension[1..-1].intern
    end

    def extension
      File.extname(path)
    end

    def input
      File.read(path)
    end

    def processors
      { sass: SassProcessor, haml: HamlProcessor }
    end

    def default_processor
      NullProcessor
    end

  end
end