
module PageObject
  module Platforms
    module SeleniumElement
      def visible?
        @element.displayed?
      end
    
      def exists?
        nil != @element
      end
    end
  end
end