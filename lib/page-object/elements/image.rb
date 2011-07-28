module PageObject
  module Elements
    class Image < Element
      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      protected

      def include_platform_for platform
        super
        if platform[:platform] == :watir
          require 'page-object/platforms/watir/image'
          self.class.send :include, PageObject::Platforms::Watir::Image
        elsif platform[:platform] == :selenium
          require 'page-object/platforms/selenium/image'
          self.class.send :include, PageObject::Platforms::Selenium::Image
        else
          raise ArgumentError, "expect platform to be :watir or :selenium"
        end
      end

    end
  end
end