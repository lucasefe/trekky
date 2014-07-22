class Trekky

  class Source

    class CanNotRenderError < StandardError
      def initialize(exception)
        @exception = exception
      end

      def backtrace
        @exception.backtrace
      end

      def message
        @exception.message
      end
    end

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
