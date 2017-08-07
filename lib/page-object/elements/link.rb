module PageObject
  module Elements
    class Link < Element

    end
    
    ::PageObject::Elements.tag_to_class[:a] = ::PageObject::Elements::Link
  end
end
