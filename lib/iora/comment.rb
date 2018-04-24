require 'yaml'
require 'deep_merge'

class Iora
  class Comment
    class << self
      def mappings
        {
          "exid"           =>   nil                ,
          "issue_sequence" =>   nil                ,
          "author"         =>   nil                ,
          "body"           =>   nil                ,
        }
      end

      def fields
        mappings.keys
      end
    end
  end
end