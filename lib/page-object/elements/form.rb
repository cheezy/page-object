
module PageObject
  module Elements
    class Form < Element

      protected

      def self.watir_finders
        super + [:action]
      end

    end

    ::PageObject::Elements.tag_to_class[:form] = ::PageObject::Elements::Form
  end
end
