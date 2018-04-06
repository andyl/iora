require 'ext/array'
require 'octokit'
require 'iora/config'

module Repo
  class Github

    attr_accessor :client, :repo_name, :repo_data

    def initialize(name, _opts = {})
      @repo_name = name
      @repo_data = []
      @client = octo_client
      # @repo = Repo.find_by(name)
      # sync_bugs
    end

    # def self.from_repo(repo)
    #   instance = allocate
    #   instance.repo = repo
    #   instance.send(:sync_bugs)
    #   instance
    # end

    def issues
      []
    end

    def issue(_id)
      {}
    end

    private

    def octo_client
      @octoclient ||= begin
        config = Iora::Config.new(:github)
        Octokit.configure do |c|
          c.login    = config.username
          c.password = config.password
        end
        stack = Faraday::RackBuilder.new do |builder|
          builder.use Faraday::HttpCache, serializer: Marshal, shared_cache: false
          builder.use Octokit::Response::RaiseError
          builder.adapter Faraday.default_adapter
        end
        Octokit.middleware = stack
      end
    end

    def sync_bugs
      issues = Octokit.issues(repo.name)
      return if issues.blank?
      issues.each_with_index do |el, idx|
        attrs = {
          stm_repo_uuid: repo.uuid         ,
          type:          "Issue::GitHub"   ,
          exid:          el["id"]          ,
          stm_title:     el["title"]       ,
          stm_labels:    labels_for(el)    ,
          stm_status:    el["state"]       ,
          comments:      comments_for(el)  ,
          html_url:      el["html_url"]    ,
          synced_at:     BugmTime.now
        }.stringify_keys
        add_event("bug#{idx}".to_sym, Event::IssueSynced.new(event_opts(attrs)))
      end
      add_event :repo, Event::RepoSynced.new(event_opts(uuid: repo.uuid))
    end

    def event_opts(args)
      cmd_opts.merge(args)
    end

    def labels_for(el)
      el["labels"].map {|x| x[:name]}.join(", ")
    end

    def comments_for(el)
      body = Octokit.issue(repo.name, el["number"])[:body]
      list = Octokit.issue_comments(repo.name, el["number"])
      lmap = list.blank? ? nil : list.map {|el| el["body"]}.join(" | ")
      base = [body, lmap].without_blanks.join(" | ")
      return "" if base.blank? || base.empty?
      base
    end
  end
end
