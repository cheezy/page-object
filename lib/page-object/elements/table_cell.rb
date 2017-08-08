module PageObject
  module Elements
    class TableCell < Element

    end

    ::PageObject::Elements.tag_to_class[:td] = ::PageObject::Elements::TableCell
    ::PageObject::Elements.tag_to_class[:th] = ::PageObject::Elements::TableCell
  end
end
