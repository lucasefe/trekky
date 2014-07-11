require 'fileutils'
require 'trekky/haml_parser'
require 'trekky/sass_parser'

module Trekky

  class Processor

    attr_reader :source_dir, :target_dir

    PARSERS = {
      :sass => SassParser,
      :haml => HamlParser
    }

    def self.run(source_dir, target_dir)
      new(source_dir, target_dir).run
    end

    def initialize(source_dir, target_dir)
      @source_dir = source_dir
      @target_dir = target_dir
    end

    def run(sources = default_sources)
      sources.each do |source|
        target = source.gsub(source_dir, target_dir)
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
      parser.new(input, source_dir, target_dir).output
    rescue Exception => e
      STDERR.puts "Error #{e.message}"
      e.backtrace.each do |line|
        STDERR.puts "  #{line}"
      end
      nil
    end

    def default_sources
      Dir.glob(File.join(source_dir, "**/*")).
        reject do |p|
          p.include?("#{source_dir}/layouts") ||
          File.directory?(p)
        end
    end

  end
end
