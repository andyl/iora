require "forwardable"
require "repo/github"
require "repo/test"

class Iora

  VERSION = "0.1.0"

  extend Forwardable

  attr_accessor :type, :repo_id, :repo

  delegate %i(issue issues) => :repo

  def initialize(type, id)
    @type = type
    @repo_id = id
    @repo = case type
      when :test then Repo::Test.new(id)
      when :github then Repo::Github.new(id)
      else
        raise "Invalid Repo Type"
    end
  end
end
