require_relative 'source'
require 'sass'

class Trekky
  class SassSource < Source

    def render
      clear_errors
      Sass.load_paths << @context.source_dir
      @output = Sass::Engine.new(input, options).render
    rescue Exception => error
      STDOUT.puts "Adding error: #{error.message}"
      add_error error
    end

    def options
      { :syntax => :sass }
    end

  end
end
