module PageObject
  module Platforms
    module WatirSelectList
      
      #
      # Return the PageObject::Elements::Option for the index provided.  Index
      # is zero based.
      #
      # @return [PageObject::Elements::Option]
      #
      def [](idx)
        PageObject::Elements::Option.new(@element.options[idx], :platform => :watir)
      end

    end
  end
end
