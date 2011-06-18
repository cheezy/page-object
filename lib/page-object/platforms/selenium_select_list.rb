module PageObject
  module Platforms
    module SeleniumSelectList
      
      #
      # Return the PageObject::Elements::Option for the index provided.  Index
      # is zero based.
      #
      # @return [PageObject::Elements::Option]
      #
      def [](idx)
        eles = @element.find_elements(:xpath, ".//child::option")
        PageObject::Elements::Option.new(eles[idx], :platform => :selenium)
      end
      
    end
  end
end
