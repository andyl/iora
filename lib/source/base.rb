module Source
  class Base
    def issues
      raise "IMPLEMENT IN SUBCLASS"
    end

    def issue(exid)
      raise "IMPLEMENT IN SUBCLASS"
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