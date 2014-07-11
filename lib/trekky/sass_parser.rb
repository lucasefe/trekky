require 'sass'
require 'trekky/parser'

module Trekky
  class SassParser < Parser

    def run
      prepare('sass', 'css') do |f|
        f.write Sass::Engine.new(File.read(source), :syntax => :sass).render
      end
    end

  end
end
