module PageObject
  module Elements
    class Video < Media

    end

    ::PageObject::Elements.type_to_class[:video] = ::PageObject::Elements::Video
  end
end
