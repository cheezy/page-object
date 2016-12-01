
module PageObject
  module Elements
    class TextArea < Element

      def self.watir_finders
        super + [:label]
      end

      def self.selenium_finders
        super + [:label]
      end

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
        element.wd.clear
      end

    end

    ::PageObject::Elements.tag_to_class[:textarea] = ::PageObject::Elements::TextArea

  end
end
