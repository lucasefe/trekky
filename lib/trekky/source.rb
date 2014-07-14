class Trekky

  class Source

    def initialize(context, path)
      @path = path
      @context = context
    end

    def render(&block)
      raise NotImplementedError      
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

  end
end