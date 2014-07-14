require 'haml'
require 'trekky/source'

class Trekky
  class HamlSource < Source

    def initialize(context, path)
      super
      @regions = {}      
    end
    
    def render(options = {}, &block)
      if block_given? || options[:layout] == false
        render_input(&block)
      else
        output = render_input
        layout.render do |name|
          if @regions.has_key?(name)
            @regions[name].call
          else
            output
          end
        end
      end
    rescue Exception => error
      render_error(error)
      nil
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
      @regions[name] = block 
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

    def inception?
      layout == @source
    end

    def layout
      @context.layouts.first
    end

    def render_error(e)
      STDERR.puts "Error #{e.message}"
      e.backtrace.each do |line|
        STDERR.puts "  #{line}"
      end
    end

  end

end