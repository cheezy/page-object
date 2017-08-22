module PageObject
  module Elements
    class Italic < Element

    end

    ::PageObject::Elements.tag_to_class[:i] = ::PageObject::Elements::Italic
  end
end
