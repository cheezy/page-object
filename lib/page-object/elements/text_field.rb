module PageObject
  module Elements
    class TextField < Element

    end

    ::PageObject::Elements.type_to_class[:text] = ::PageObject::Elements::TextField
    ::PageObject::Elements.type_to_class[:password] = ::PageObject::Elements::TextField
  end
end
