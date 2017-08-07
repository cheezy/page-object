module PageObject
  module Elements
    class Button < Element

    end

    ::PageObject::Elements.type_to_class[:submit] = ::PageObject::Elements::Button
    ::PageObject::Elements.type_to_class[:image] = ::PageObject::Elements::Button
    ::PageObject::Elements.type_to_class[:button] = ::PageObject::Elements::Button
    ::PageObject::Elements.type_to_class[:reset] = ::PageObject::Elements::Button
  end
end
