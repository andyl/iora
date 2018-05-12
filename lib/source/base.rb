module Source
  class Base
    def issues
      raise "IMPLEMENT IN SUBCLASS"
    end

    def issue(exid)
      issues.select {|x| x["exid"] == exid}.first
    end

    def issue_by_exid(exid)
      issue(exid)
    end

    def issue_hexid(hexid)
      issues.select {|x| x["body"] =~ /(^| |>)\/#{hexid}($| |<)/}.first
    end

    def create(title, body, opts = {} )
      raise "IMPLEMENT IN SUBCLASS"
    end

    def update(issue_id, opts)
      raise "IMPLEMENT IN SUBCLASS"
    end

    def close(issue_id)
      raise "IMPLEMENT IN SUBCLASS"
    end

    def open(issue_id)
      raise "IMPLEMENT IN SUBCLASS"
    end

    def create_comment(comment_id, body)
      raise "IMPLEMENT IN SUBCLASS"
    end

    def update_comment(comment_id, body)
      raise "IMPLEMENT IN SUBCLASS"
    end
  end
end