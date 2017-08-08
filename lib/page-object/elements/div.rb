module PageObject
  module Elements
    class Div < Element

    end

    ::PageObject::Elements.tag_to_class[:div] = ::PageObject::Elements::Div
  end
end
