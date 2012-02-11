module PageObject
  module Javascript
    
    module Prototype
      #
      # return the number of pending ajax requests
      #
      def self.pending_requests
        'return Ajax.activeRequestCount'
      end
    end
    
  end
end
