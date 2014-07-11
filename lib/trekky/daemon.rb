require 'rb-fsevent'
require 'trekky/processor'

module Trekky
  class Daemon

    attr_reader :context

    def initialize(context)
      @context = context
    end

    def run
      STDOUT.puts "   Initial run (daemon mode)"
      process
      fsevent = FSEvent.new
      fsevent.watch context.source_dir do |directories|
        STDOUT.puts "\n   Processing: #{directories.inspect}"
        process
        STDOUT.puts "   Done processing. "
      end
      fsevent.run
    end

    def process
      Processor.run context
    end

  end
end
