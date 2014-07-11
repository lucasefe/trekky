require 'rb-fsevent'
require 'trekky/processor'

module Trekky
  class Daemon

    def self.run(source_dir, target_dir)
      new(source_dir, target_dir).run
    end

    def initialize(source_dir, target_dir)
      @source_dir = source_dir
      @target_dir = target_dir
    end

    def run
      STDOUT.puts "   Initial run (daemon mode)"
      process
      fsevent = FSEvent.new
      fsevent.watch @source_dir do |directories|
        STDOUT.puts "\n   Processing: #{directories.inspect}"
        process
        STDOUT.puts "   Done processing. "
      end
      fsevent.run
    end

    def process
      Processor.run(@source_dir, @target_dir)
    end

  end
end
