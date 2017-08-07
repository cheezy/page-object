module PageObject
  module Elements
    class Bold < Element

    end

    ::PageObject::Elements.tag_to_class[:b] = ::PageObject::Elements::Bold
  end
end
