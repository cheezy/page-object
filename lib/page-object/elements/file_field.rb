module PageObject
  module Elements
    class FileField < Element

    end

    ::PageObject::Elements.type_to_class[:file] = ::PageObject::Elements::FileField
  end
end
