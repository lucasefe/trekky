require 'haml'
require 'trekky/source'

class Trekky
  class HamlSource < Source
    
    def render(&block)
      if block_given?
        render_input(&block)
      else
        unless inception?
          layout.render do
            render_input
          end
        else
          render_input
        end
      end
    rescue Exception => error
      render_error(error)
      nil
    end

    def type
      :haml
    end

    private

    def render_input(&block)
      Haml::Engine.new(input).render(&block)
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