require 'trekky/parser'
require 'haml'

module Trekky
  class HamlParser < Parser

    def output
      if layout?
        render(layout_contents) { render(input) }
      else
        render(input)
      end
    end

    private

    def layout_contents
      File.read(layout)
    end

    def layout?
      File.exists?(layout)
    end

    def layout(name = "default")
      File.join(source_dir, "layouts", "#{name}.haml")
    end

    def render(input, &block)
      if block_given?
        Haml::Engine.new(input).render(&block)
      else
        Haml::Engine.new(input).render
      end
    end
  end
end
