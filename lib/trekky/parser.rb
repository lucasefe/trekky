module Trekky
  class Parser
    attr_reader :input, :source_dir, :target_dir

    def initialize(input, source_dir, target_dir)
      @input = input
      @source_dir = source_dir
      @target_dir = target_dir
    end

    def output
      raise NotImplementedError
    end

  end
end
