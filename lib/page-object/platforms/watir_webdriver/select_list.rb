module PageObject
  module Platforms
    module WatirWebDriver
      module SelectList

        #
        # Return the PageObject::Elements::Option for the index provided.  Index
        # is zero based.
        #
        # @return [PageObject::Elements::Option]
        #
        def [](idx)
          Object::PageObject::Elements::Option.new(options[idx], :platform => :watir_webdriver)
        end

        #
        # Select a value from the list
        #
        def select(value)
          @element.select(value)
        end

        #
        # Return an array of Options contained in the select lit.
        #
        # @return [array of PageObject::Elements::Option]
        #
        def options
          elements = []
          options = @element.wd.find_elements(:xpath, child_xpath)
          options.each do |opt|
            elements << Object::PageObject::Elements::Option.new(opt, :platform => :watir_webdriver)
          end
          elements
        end

        #
        # @return [Array<String>] An array of strings representing the text value of the currently selected options.
        #
        def selected_options
          @element.selected_options
        end

      end
    end
  end

end
