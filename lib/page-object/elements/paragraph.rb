module PageObject
  module Elements
    class Paragraph < Element

    end

    ::PageObject::Elements.tag_to_class[:p] = ::PageObject::Elements::Paragraph
  end
end
