module PageObject
  module Elements
    class CheckBox < Element

    end

    ::PageObject::Elements.type_to_class[:checkbox] = ::PageObject::Elements::CheckBox
  end
end
