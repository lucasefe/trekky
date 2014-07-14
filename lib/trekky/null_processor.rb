require 'haml'

class Trekky
  class NullProcessor

    def initialize(source)
      @source = source
    end

    def render
      @source.input
    end

    def type
    end

  end
end