
module PageObject
  module Elements
    class TextField < Element

      def append(text)
        element.send_keys text
      end

      #
      # Set the value of the TextField
      #
      def value=(new_value)
        element.set(new_value)
      end

      protected

      def self.watir_finders
        super + [:title, :value, :text, :label]
      end

    end

    ::PageObject::Elements.type_to_class[:text] = ::PageObject::Elements::TextField
    ::PageObject::Elements.type_to_class[:password] = ::PageObject::Elements::TextField
  end
end
