require "forwardable"
require "iora/version"
require "repo/github"
require "repo/test"

# asdf
class Iora

  extend Forwardable

  attr_accessor :repo, :type

  delegate %i(issue issues) => :repo

  def initialize(type, id)
    @type = type
    @repo = case type
      when :test then Repo::Test.new(id)
      when :github then Repo::Github.new(id)
      else
        raise "Invalid Repo Type"
    end
  end
end
