module PageObject
  module Platforms
    module SeleniumWebDriver
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
          find_options.find do |option|
            option.text == value
          end.click
        end

        #
        # Select the option(s) whose value attribute matches the given
        # string
        #
        def select_value(value)
          options = find_options.find_all do |option|
            option.attribute('value') == value
          end
          options.each {|opt| opt.click}
        end

        #
        # Return an array of Options contained in the select list.
        #
        # @return [array of PageObject::Elements::Option]
        def options
          find_options.map { |e| ::PageObject::Elements::Option.new(e, :platform => @platform.class::PLATFORM_NAME) }
        end

        #
        # @return [Array<String>] An array of strings representing the text of the currently selected options.
        #
        def selected_options
          find_options.map { |e| e.text if e.selected? }.compact
        end

        #
        # @return [Array<String>] An array of strings representing the value of the currently selected options.
        #
        def selected_values
          find_options.map { |e| e.attribute('value') if e.selected? }.compact
        end

        #
        # Returns true if the select list has one or more options where text or label matches the given value.
        #
        # @param [String, Regexp] value A value.
        # @return [Boolean]
        def include?(value)
          find_options.any? { |e| e.text == value }
        end

        #
        # Returns true if any of the selected options' text match the given value.
        #
        # @param [String, Regexp] value A value.
        # @return [Boolean]
        def selected?(value)
          selected = find_options.select { |e| e if e.selected? }
          selected.any? { |e| e.text == value }
        end

        #
        # Deselect all selected options.
        #
        def clear
          find_options.select { |e| e.selected? }.each { |o| o.click }
        end

        private

        def find_options
          element.find_elements(:xpath, child_xpath)
        end
      end
    end
  end

end
