
module PageObject
  module Elements
    class FileField < Element

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      protected

      def self.watir_finders
        super + [:title, :label]
      end

      def self.selenium_finders
        super + [:title, :label]
      end

    end

    ::PageObject::Elements.type_to_class[:file] = ::PageObject::Elements::FileField

  end
end
