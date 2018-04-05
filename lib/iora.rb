require "iora/version"
require "repo/github"
require "repo/test"

class Iora
  def initialize(type, id)
    case type
    when :test then Repo::Test.new(id)
    when :github then Repo::Github.new(id)
    else
      raise "Invalid Repo Type"
    end
  end
end
