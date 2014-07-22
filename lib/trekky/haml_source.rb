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

    def render(options = {}, &block)
      clear_errors
      @output = if block_given? || options[:layout] == false
        render_input(&block)
      else
        buffer = render_input
        if layout
          layout.render do |name|
            if region.nil?
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

    def partial(name)
      source = context.find_partial(name)
      if source
        source.render(layout: false)
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

    def render_input(&block)
      Haml::Engine.new(input).render(self, locals, &block)
    end

    def locals
      {}
    end

    def layout
      @context.layouts.first
    end

  end
end
