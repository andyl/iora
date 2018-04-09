require "forwardable"
require "source/github"
require "source/yaml"

class Iora

  VERSION = "0.1.0"

  extend Forwardable

  attr_accessor :type, :source_id, :source

  delegate %i(issue issues) => :source

  def initialize(type, id)
    @type = type.to_sym
    @source_id = id
    @source = case @type
      when :yaml then Source::Yaml.new(id)
      when :github then Source::Github.new(id)
      else
        raise "Invalid Source Type"
    end
  end
end
