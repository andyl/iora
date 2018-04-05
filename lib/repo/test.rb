require 'yaml'

module Repo
  class Test
    def initialize(file_path)
      @repo = YAML.load(file_path)
    end
  end
end