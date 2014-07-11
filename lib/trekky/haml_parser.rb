require 'trekky/parser'
require 'haml'

module Trekky
  class HamlParser < Parser

    def render
      prepare('haml', 'html') do |f|
        f.write Haml::Engine.new(File.read(source)).render
      end
    end

  end
end
