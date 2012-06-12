module PageObject
  module Javascript

    module YUI
      #
      # return the number of pending ajax requests
      #
      def self.pending_requests
         "var inProgress=0
         for(var i=0; i < YAHOO.util.Connect._transaction_id; i++) {
           if(YAHOO.util.Connect.isCallInProgress(i))
             inProgress++;
         }
         return inProgress;"
      end
    end

  end
end