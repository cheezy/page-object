module PageObject
  module Platforms
    module Selenium
      module SelectList

        #
        # Return the PageObject::Elements::Option for the index provided.  Index
        # is zero based.
        #
        # @return [PageObject::Elements::Option]
        #
        def [](idx)
          options[idx]
        end

        #
        # Return an array of Options contained in the select lit.
        #
        # @return [array of PageObject::Elements::Option]
        def options
          options = @element.find_elements(:xpath, child_xpath)
          elements = []
          options.each do |opt|
            elements << Object::PageObject::Elements::Option.new(opt, :platform => :selenium)
          end
          elements
        end
      end
    end
  end

end