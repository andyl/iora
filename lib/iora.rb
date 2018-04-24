require "forwardable"
require "source/github"
require "source/yaml"
require "iora_error"

class Iora

  VERSION = "0.1.1"

  extend Forwardable

  attr_accessor :type, :source_id, :source

  delegate %i(issue issues create update create_comment update_comment) => :source

  def initialize(type, id)
    @type = type.to_sym
    @source_id = id
    @source = case @type
      when :yaml then Source::Yaml.new(id)
      when :github then Source::Github.new(id)
      else
        raise IoraError::InvalidSourceType, "Invalid Source Type (#{type})"
    end
  end
end

