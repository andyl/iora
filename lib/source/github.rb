require 'ext/array'
require 'ext/hash'
require 'octokit'
require 'iora/config'
require 'iora/issue'

module Source
  class Github

    attr_accessor :repo_name, :repo_data

    def initialize(name, _opts = {})
      configure_octokit
      @repo_name = name
      @repo_data = Octokit.issues(repo_name)
    end

    def issues
      @lcl_issues ||= repo_data.map {|el| convert(el)}
    end

    def issue(exid)
      issues.select {|x| x["exid"] == exid}.first
    end

    private

    def convert(el)
      lcl_fields = Iora::Issue.fields + %w(html_url)
      sel = el.to_hash.stringify_keys
      sel
        .map_keys(Iora::Issue.mappings)
        .map_keys({"stm_status" => "state", "exid" => "id"})
        .merge(labels_for(sel))
        .only(*lcl_fields)
        .without_blanks
    end

    def add_fields(input)
      names = input["labels"].map {|el| el[:name]}
      input["stm_labels"] = names.join(", ")
      input
    end

    def labels_for(el)
      text = el["labels"].map {|x| x[:name]}.join(", ")
      { "stm_labels" => text }
    end

    def configure_octokit
      @octoclient ||= begin
        config = Iora::Config.new(:github)
        Octokit.configure do |c|
          c.login    = config.username
          c.password = config.password
        end
      end
    end
  end
end
