module PageObject
  module Javascript
    
    module JQuery
      #
      # return the number of pending ajax requests
      #
      def self.pending_requests
        'return jQuery.active'
      end
    end
    
  end
end
