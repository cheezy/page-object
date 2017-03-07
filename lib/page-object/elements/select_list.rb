module PageObject
  module Elements
    class SelectList < Element

      #
      # Return the PageObject::Elements::Option for the index provided.  Index
      # is zero based.
      #
      # @return [PageObject::Elements::Option]
      #
      def [](idx)
        options[idx]
      end

      def select(value)
        options.each do |option|
          if option.attribute(:text) == value
            return option.click
          elsif option.attribute(:value) == value
            return option.click
          end
        end
        raise "Failed to select value [#{value}] from list. Available options text: [#{options_text}] \n Available options value [#{options_value}]"
      end

      #
      # Return an array of Options contained in the select list.
      #
      # @return [array of PageObject::Elements::Option]
      #
      def options
        element.options.map { |e| ::PageObject::Elements::Option.new(e, :platform => :watir) }
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

      protected

      def child_xpath
        ".//child::option"
      end

      def self.watir_finders
        super + [:text, :value, :label]
      end

    end

    ::PageObject::Elements.tag_to_class[:select] = ::PageObject::Elements::SelectList
  end
end