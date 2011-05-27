
module PageObject
  module Platforms
    module WatirElement
      def visible?
        @element.present?
      end

      def exists?
        @element.exists?
      end
      
      def text
        @element.text
      end
    end
  end
end