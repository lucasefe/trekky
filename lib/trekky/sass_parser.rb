require 'sass'
require 'trekky/parser'

module Trekky
  class SassParser < Parser

    def output
      Sass::Engine.new(input, :syntax => :sass).render
    end

  end
end
