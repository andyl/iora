require 'yaml'
require 'deep_merge'

class Iora
  class Issue
    class << self
      def mappings
        {
          "type"           =>   nil                         ,
          "uuid"           =>   %w(issue_uuid)              ,
          "exid"           =>   nil                         ,
          "xfields"        =>   nil                         ,
          "jfields"        =>   nil                         ,
          "stm_issue_uuid" =>   %w(issue_uuid uuid)         ,
          "stm_repo_uuid"  =>   %w(repo_uuid)               ,
          "stm_title"      =>   %w(title name)              ,
          "stm_status"     =>   %w(status)                  ,
          "stm_labels"     =>   %w(labels)                  ,
          "stm_jfields"    =>   nil                         ,
          "stm_xfields"    =>   nil                         ,
        }
      end

      def fields
        mappings.keys
      end
    end
  end
end