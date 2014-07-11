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
      prepare('haml', 'html') do |f|
        out = if layout?
          Haml::Engine.new(File.read(layout)).render do
            Haml::Engine.new(File.read(source)).render
          end
        else
          Haml::Engine.new(File.read(source)).render
        end
        f.write out
      end
    end

  end
end
