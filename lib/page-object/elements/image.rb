module PageObject
  module Elements
    class Image < Element

    end

    ::PageObject::Elements.tag_to_class[:img] = ::PageObject::Elements::Image
    
  end
end
