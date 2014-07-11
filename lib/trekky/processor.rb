require 'fileutils'
require 'trekky/haml_parser'
require 'trekky/sass_parser'

module Trekky

  class Processor

    PARSERS = {
      :sass => SassParser,
      :haml => HamlParser
    }

    attr_reader :context

    def initialize(context)
      @context = context
    end

    def run(sources = default_sources)
      sources.each do |source|
        target = source.gsub(context.source_dir, context.target_dir)
        extension = File.extname(source)[1..-1].intern
        output = if parser = PARSERS[extension]
          target.gsub!(/\.#{extension}/, '')
          parse(parser, source)
        else
          File.read(source)
        end

        STDOUT.puts "-> #{source} to #{target}"

        write output, target if output
      end
    end

    private

    def write(output, target)
      FileUtils.mkdir_p(File.dirname(target))
      File.open(target, "wb") {|f| f.write(output) }
    end

    def parse(parser, source)
      input = File.read(source)
      parser.new(input, context).output
    rescue Exception => e
      STDERR.puts "Error #{e.message}"
      e.backtrace.each do |line|
        STDERR.puts "  #{line}"
      end
      nil
    end

    def default_sources
      @default_sources ||= context.sources(true)
    end

  end
end
