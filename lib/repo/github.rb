require 'ext/array'
require 'octokit'
require 'iora/config'

module Repo
  class Github

    attr_accessor :repo_name, :repo_data

    def initialize(name, _opts = {})
      configure_octokit
      @repo_name = name
      @repo_data = Octokit.issues(repo_name)
    end

    def issues
      repo_data
    end

    def issue(_id)
      {}
    end

    private

    def configure_octokit
      @octoclient ||= begin
        config = Iora::Config.new(:github)
        Octokit.configure do |c|
          c.login    = config.username
          c.password = config.password
        end
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
      end
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
