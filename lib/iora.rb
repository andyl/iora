require "forwardable"
require "source/github"
require "source/yaml"
require "iora/version"
require "iora_error"

class Iora

  extend Forwardable

  attr_accessor :type, :source_id, :source

  subs = %i(issue issues create update open close create_comment update_comment)
  delegate subs => :source

  def initialize(type, id, opts = {})
    @type = type.to_sym
    @source_id = id
    @source = case @type
      when :yaml then Source::Yaml.new(id, opts)
      when :github then Source::Github.new(id, opts)
      else
        raise IoraError::InvalidSourceType, "Invalid Source Type (#{type})"
    end
  end
end

