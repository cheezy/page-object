module PageObject
  module Elements
    class TableCell < Element

      #
      # return true if the element is enabled
      #
      def enabled?
        true
      end

    end

    ::PageObject::Elements.tag_to_class[:td] = ::PageObject::Elements::TableCell
    ::PageObject::Elements.tag_to_class[:th] = ::PageObject::Elements::TableCell
    
  end
end
