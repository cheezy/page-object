module PageObject
  module Javascript

    module Angular
      #
      # return the number of pending ajax requests
      #
      def self.pending_requests
        'return getAllAngularTestabilities().filter(x => !x.isStable()).length;'
      end
    end

  end
end
