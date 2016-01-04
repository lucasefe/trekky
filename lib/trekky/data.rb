require 'ostruct'
require 'yaml'

class Trekky
  class Data
    class DeepStruct < OpenStruct
      def initialize(hash = nil)
        @table = {}
        @hash_table = {}

        if hash
          hash.each do |k, v|
            @table[k.to_sym] = (v.is_a?(Hash) ? self.class.new(v) : v)
            @hash_table[k.to_sym] = v

            new_ostruct_member(k)
          end
        end
      end

      def to_h
        @hash_table
      end
    end

    def initialize(path)
      @path = path
      @data = {}
      super()
    end

    def method_missing(method_name, *_args)
      if @data.key?(method_name)
        @data[method_name]
      else
        @data[method_name] = load_data(method_name)
      end
    end

    private

    def load_data(name)
      yaml = YAML.load_file(File.join(@path, "#{name}.yml"))
      if yaml.respond_to?(:each)
        yaml.map { |y| DeepStruct.new(y) }
      else
        DeepStruct.new(yaml)
      end
    end
  end
end
