module PageObject
  module Javascript
    
    module Dojo
      #
      # return the number of pending ajax requests
      #
      def self.pending_requests
        'return dojo.io.XMLHTTPTransport.inFlight.length'
      end
    end
    
  end
end
