module Trekky
  class Context

    attr_reader :source_dir, :target_dir

    def initialize(source_dir, target_dir)
      @source_dir = source_dir
      @target_dir = target_dir
    end

    def sources(reload = false)
      reset_files if reload
      files[:sources]
    end

    def partials
      files[:partials]
    end

    def layouts
      files[:layouts]
    end

    def reset_files
      @files = nil
    end

    def files
      @files ||= begin
        dict = Hash.new
        dict.default_proc = proc { |hash, key| hash[key] = []}
        all_files.each do |path|
          next if File.directory?(path)

          if path.include?("#{source_dir}/layouts")
            dict[:layouts] << path
            next
          end

          if File.basename(path)[0] == '_'
            dict[:partials] << path
            next
          end

          dict[:sources] << path
        end
        dict
      end
    end

    def all_files
      Dir.glob(File.join(source_dir, "**/*"))
    end

  end
end
