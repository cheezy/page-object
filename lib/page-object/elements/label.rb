module PageObject
  module Elements
    class Label < Element

    end

    ::PageObject::Elements.tag_to_class[:label] = ::PageObject::Elements::Label
  end
end
