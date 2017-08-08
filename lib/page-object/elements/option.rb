module PageObject
  module Elements
    class Option < Element

    end

    ::PageObject::Elements.tag_to_class[:option] = ::PageObject::Elements::Option
  end
end
