require 'ext/hash'
require 'yaml'
require_relative './base'

module Source
  class Yaml < Base

    attr_accessor :repo_data, :data_file

    def initialize(data_file)
      @data_file = File.expand_path(data_file)
      unless File.exist?(data_file)
        raise(IoraError::FileNotFound, "File Not Found (#{data_file})")
      end
      @repo_data = YAML.load_file(data_file)
    end

    def issues
      repo_data.map {|el| convert(el)}
    end

    def issue(exid)
      issues.select {|x| x["exid"] == exid}.first
    end

    private

    def convert(el)
      el
        .stringify_keys
        .map_keys(Iora::Issue.mappings)
        .only(*Iora::Issue.fields)
    end
  end
end
