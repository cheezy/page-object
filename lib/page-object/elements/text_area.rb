
module PageObject
  module Elements
    class TextArea < Element

      #
      # Set the value of the TextArea
      #
      def value=(new_value)
        element.set(new_value)
      end

      #
      # Clear the TextArea
      #
      def clear
        element.clear
      end

      #
      # append the text to the end of the text in the text area
      #
      def append(text)
        element.append(text)
      end

      protected

      def self.watir_finders
        super + [:label]
      end

    end

    ::PageObject::Elements.tag_to_class[:textarea] = ::PageObject::Elements::TextArea

  end
end
