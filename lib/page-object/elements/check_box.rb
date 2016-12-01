module PageObject
  module Elements
    class CheckBox < Element

      #
      # check the checkbox
      #
      def check
        element.set
      end

      #
      # uncheck the checkbox
      #
      def uncheck
        element.clear
      end

      #
      # return true if checkbox is checked
      #
      def checked?
        element.set?
      end

      protected

      def self.watir_finders
        super + [:value, :label]
      end

    end

    ::PageObject::Elements.type_to_class[:checkbox] = ::PageObject::Elements::CheckBox

  end
end
