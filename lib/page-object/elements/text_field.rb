module PageObject
  module Elements
    class TextField < Element

      #
      # Set the value of the TextField
      #
      def value=(new_value)
        element.set(new_value)
      end

    end

    ::PageObject::Elements.type_to_class[:text] = ::PageObject::Elements::TextField
    ::PageObject::Elements.type_to_class[:password] = ::PageObject::Elements::TextField
  end
end
