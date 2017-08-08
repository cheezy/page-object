module PageObject
  module Elements
    class HiddenField < Element

    end

    ::PageObject::Elements.type_to_class[:hidden] = ::PageObject::Elements::HiddenField
  end
end
