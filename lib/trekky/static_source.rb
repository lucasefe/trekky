require 'haml'
require_relative 'source'

class Trekky
  class StaticSource < Source

    def render
      input
    end

    def type

    end

  end
end
