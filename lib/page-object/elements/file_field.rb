
module PageObject
  module Elements
    class FileField < Element

      #
      # Set the value of the FileField
      #
      def value=(new_value)
        element.set(new_value)
      end

    end

    ::PageObject::Elements.type_to_class[:file] = ::PageObject::Elements::FileField

  end
end
