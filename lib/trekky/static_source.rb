require 'haml'
require_relative 'source'

class Trekky
  class StaticSource < Source

    def render
      clear_errors
      @output = input
    end

    def type

    end

  end
end
