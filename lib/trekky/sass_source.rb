require_relative 'source'
require 'sass'

class Trekky
  class SassSource < Source
    HTML_ESCAPE_ONCE_REGEXP = /["><']|&(?!([a-zA-Z]+|(#\d+));)/
    HTML_ESCAPE = {
      '&' => '&amp;',
      '>' => '&gt;',
      '<' => '&lt;',
      '"' => '&quot;',
      "'" => '&#39;'
    }

    def render
      clear_errors
      Sass.load_paths << @context.source_dir
      @output = Sass::Engine.new(input, options).render
    rescue Exception => error
      add_error error
    end

    def render_error(error)
      input = error.message.to_s.gsub(HTML_ESCAPE_ONCE_REGEXP, HTML_ESCAPE)
      sprintf('body::before{ content:"%s" }', input)
    end

    def options
      { :syntax => :sass }
    end

  end
end
