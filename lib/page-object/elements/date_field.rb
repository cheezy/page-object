module PageObject
  module Elements
    class DateField < Element

    end

    ::PageObject::Elements.type_to_class[:date] = ::PageObject::Elements::DateField
  end
end

