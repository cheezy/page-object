module PageObject
  module Elements
    class RadioButton < Element

    end

    ::PageObject::Elements.type_to_class[:radio] = ::PageObject::Elements::RadioButton
  end
end
