module PageObject
  module Elements
    class Form < Element

    end

    ::PageObject::Elements.tag_to_class[:form] = ::PageObject::Elements::Form
  end
end
