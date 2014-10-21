# encoding: UTF-8

class Trekky

  class Source

    attr_reader :output, :context, :path, :errors
    attr_reader :body, :header

    def initialize(context, path)
      @path = path
      @context = context
      @errors = []
      read
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

    def read
      @header, @body = read_file
    end

    def add_error(error)
      STDOUT.puts "ERROR: #{error.message} (#{path}) -> #{error.backtrace.first}"
      @errors << error
      nil
    end

    def clear_errors
      @errors = []
    end

    def read_file
      return {}, File.read(path)
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
