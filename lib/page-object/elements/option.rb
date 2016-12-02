module PageObject
  module Elements
    class Option < Element

      #
      # returns true if the option is selected
      #
      def selected?
        element.selected?
      end

    end

    ::PageObject::Elements.tag_to_class[:option] = ::PageObject::Elements::Option
    
  end
end
