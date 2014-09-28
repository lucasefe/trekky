class Trekky

  class Source

    attr_reader :output, :context, :path, :errors

    def initialize(context, path)
      @path = path
      @context = context
      @errors = []
    end

    def data
      @context.data
    end

    def render(&block)
      raise NotImplementedError
    end

    def valid?
      @errors.empty?
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

    def add_error(error)
      STDOUT.puts "ERROR: #{error.message} (#{path})"
      @errors << error
      nil
    end

    def clear_errors
      @errors = []
    end

    def render_errors
      @errors.map do |error|
        render_error(error)
      end.join("<br/>")
    end

    def render_error(error)
      Haml::Engine.new(<<-INPUT.gsub(" "*8, "")).render(self, {error: error})
        %h1 File: #{path}
        %h3 Error: #{error.message}
        %pre
          %code
            - error.backtrace.each do |line|
              = line
              %br
      INPUT
    end
  end
end
