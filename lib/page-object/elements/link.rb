module PageObject
  module Elements
    class Link < Element

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      protected

      def self.watir_finders
        super + [:href, :text]
      end

      def self.watir_mapping
        super.merge({:link => :text, :link_text => :text})
      end

      def self.selenium_finders
        super + [:link, :link_text]
      end

      def self.selenium_mapping
        super.merge(:text => :link_text)
      end

      def include_platform_for platform
        super
        if platform[:platform] == :selenium
          require 'page-object/platforms/selenium/link'
          self.class.send :include, PageObject::Platforms::Selenium::Link
        end
      end
    end
  end
end