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
          options[idx]
        end

        #
        # Select a value from the list
        #
        def select(value)
          element.select(value)
        end

        #
        # Select the option(s) whose value attribute matches the given
        # string
        #
        def select_value(value)
          element.select_value(value)
        end

        #
        # Return an array of Options contained in the select list.
        #
        # @return [array of PageObject::Elements::Option]
        #
        def options
          element.options.map { |e| ::PageObject::Elements::Option.new(e, :platform => @platform.class::PLATFORM_NAME) }
        end

        #
        # @return [Array<String>] An array of strings representing the text of the currently selected options.
        #
        def selected_options
          element.selected_options.map { |e| e.text }.compact
        end

        #
        # @return [Array<String>] An array of strings representing the value of the currently selected options.
        #
        def selected_values
          element.selected_options.map { |e| e.value }.compact
        end

        #
        # Returns true if the select list has one or more options where text or label matches the given value.
        #
        # @param [String, Regexp] value A value.
        # @return [Boolean]
        def include?(value)
          element.include? value
        end
        
        #
        # Returns true if any of the selected options' text or label match the given value.
        #
        # @param [String, Regexp] value A value.
        # @return [Boolean]
        def selected?(value)
          element.selected? value
        end
      end
    end
  end
end
