module PageObject
  module Elements
    class RadioButton < Element

      #
      # select the radiobutton
      #
      def select
        element.set
      end

      #
      # return if it is selected
      #
      def selected?
        element.set?
      end

    end

    ::PageObject::Elements.type_to_class[:radio] = ::PageObject::Elements::RadioButton
  end
end
