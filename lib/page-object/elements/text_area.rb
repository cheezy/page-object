module PageObject
  module Elements
    class TextArea < Element

      #
      # Set the value of the TextArea
      #
      def value=(new_value)
        element.set(new_value)
      end

    end

    ::PageObject::Elements.tag_to_class[:textarea] = ::PageObject::Elements::TextArea
  end
end
