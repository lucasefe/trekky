module Trekky
  class Context

    attr_reader :source_dir, :target_dir

    def initialize(source_dir, target_dir)
      @source_dir = source_dir
      @target_dir = target_dir
    end

  end
end
