require 'haml'
require_relative 'source'

class Trekky
  class HamlSource < Source

    attr_reader :regions

    def initialize(context, path)
      super
      @regions = {}
      @env = {}
    end

    def render(options = {}, locals = {}, &block)
      clear_errors
      @output = if block_given? || options[:layout] == false
        render_input(locals, &block)
      else
        buffer = render_input
        if layout
          layout.render({}, locals) do |name|
            if name.nil?
              buffer
            elsif regions.has_key?(name)
              regions[name]
            end
          end
        else
          buffer
        end
      end
    rescue Exception => error
      add_error error
    end

    def partial(name, locals = {})
      source = context.find_partial(name)
      if source
        source.render({layout: false}, locals)
      else
        STDERR.puts "[ERROR] Can't find partial: #{name}"
      end
    end

    def content_for(name, &block)
      return unless block_given?
      regions[name] = capture_haml(&block)
    end

    def type
      :haml
    end

    private

    def render_input(locals = {}, &block)
      Haml::Engine.new(body).render(self, locals, &block)
    end

    def layout
      name = header["layout"] || 'default.haml' 
      context.find_layout(name)
    end

    def read_file
      regexp = /\A(---\s*\n.*?\n?)^((---|\.\.\.)\s*$\n?)/m
      content = File.read(path)
      if m = regexp.match(content)
        return YAML.load(m[0]), m.post_match
      else
        return {}, content
      end
    end

  end
end
