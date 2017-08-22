module PageObject
  module Elements
    class Heading < Element

    end

    ::PageObject::Elements.tag_to_class[:h1] = ::PageObject::Elements::Heading
    ::PageObject::Elements.tag_to_class[:h2] = ::PageObject::Elements::Heading
    ::PageObject::Elements.tag_to_class[:h3] = ::PageObject::Elements::Heading
    ::PageObject::Elements.tag_to_class[:h4] = ::PageObject::Elements::Heading
    ::PageObject::Elements.tag_to_class[:h5] = ::PageObject::Elements::Heading
    ::PageObject::Elements.tag_to_class[:h6] = ::PageObject::Elements::Heading
  end
end
