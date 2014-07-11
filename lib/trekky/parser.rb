module Trekky
  class Parser

    attr_reader :input, :context

    def initialize(input, context)
      @input = input
      @context = context
    end

    def output
      raise NotImplementedError
    end

  end
end
