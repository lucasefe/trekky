require_relative 'source'
require 'sass'

class Trekky
  class SassSource < Source

    def render
      Sass.load_paths << @context.source_dir
      Sass::Engine.new(input, options).render
    rescue Exception => error
      raise CanNotRenderError, error
    end

    def options
      { :syntax => :sass }
    end

  end
end
