module PageObject
  module Elements
    class Span < Element

    end

    ::PageObject::Elements.tag_to_class[:span] = ::PageObject::Elements::Span
  end
end
