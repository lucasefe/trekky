require 'sass'

class Trekky 
  class SassProcessor

    def initialize(source)
      @source = source
    end

    def render
      Sass::Engine.new(@source.input, :syntax => :sass).render
    end
	
	def type
      :sass
    end

  end
end
