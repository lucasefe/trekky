require_relative 'source'
require 'sass'

class Trekky 
  class SassSource < Source

    def render
      Sass::Engine.new(input, :syntax => :sass).render
    end
	
  	def type
      :sass
    end

  end
end
