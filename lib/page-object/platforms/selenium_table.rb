module PageObject
  module Platforms
    module SeleniumTable      
      
      #
      # Return the PageObject::Elements::TableRow for the index provided.  Index
      # is zero based.
      #
      def [](idx)
        element = @element.find_element(:xpath, ".//tr[#{idx+1}]")
        PageObject::Elements::TableRow.new(element, :platform => :selenium)
      end

      #
      # override PageObject::Platforms::SeleniumElement because exists? is not
      # available on a table element in Selenium.
      #
      def exists?
        raise "exists? not available on table element"
      end
      
    end
  end
end