module PageObject
  module Javascript

    module AngularJS
      #
      # return the number of pending ajax requests
      #
      def self.pending_requests
        'return angular.element(document.body).injector().get(\'$http\').pendingRequests.length;'
      end
    end

  end
end
