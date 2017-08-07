module PageObject
  module Elements
    class ListItem < Element

    end

    ::PageObject::Elements.tag_to_class[:li] = ::PageObject::Elements::ListItem
  end
end
