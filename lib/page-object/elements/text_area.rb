module PageObject
  module Elements
    class TextArea < Element

    end

    ::PageObject::Elements.tag_to_class[:textarea] = ::PageObject::Elements::TextArea
  end
end
