module PageObject
  module Elements
    class Audio < Media

    end

    ::PageObject::Elements.type_to_class[:audio] = ::PageObject::Elements::Audio
  end
end
