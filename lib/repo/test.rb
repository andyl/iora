require 'yaml'

module Repo
  class Test

    attr_accessor :repo_data, :data_file

    def initialize(data_file)
      @data_file = File.expand_path(data_file)
      raise("File Not Found") unless File.exist?(data_file)
      @repo_data = YAML.load_file(data_file)
    end

    def issues
      repo_data
    end

    def issue(_id)
      {}
    end
  end
end