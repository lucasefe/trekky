require 'trekky/parser'
require 'haml'

module Trekky
  class HamlParser < Parser

    def layout?
      File.exists?(layout)
    end

    def layout(name = "default")
      File.join(source_dir, "layouts", "#{name}.haml")
    end

    def run
      prepare('haml', 'html') do
        if layout?
          render(layout) { render(source) }
        else
          render(source)
        end
      end
    end

    def render(source, &block)
      if block_given?
        Haml::Engine.new(File.read(source)).render(&block)
      else
        Haml::Engine.new(File.read(source)).render
      end
    end
  end
end
