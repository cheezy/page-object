module PageObject
  module Elements
    class Image < Element
      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      protected

      def self.watir_finders
        super + [:alt, :src]
      end

      def self.selenium_finders
        super + [:alt, :src, :css]
      end

    end

    ::PageObject::Elements.tag_to_class[:img] = ::PageObject::Elements::Image
    
  end
end
