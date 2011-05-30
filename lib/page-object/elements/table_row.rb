module PageObject
  module Elements
    class TableRow < Element

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end
      
      protected
      
      def include_platform_for platform
        super
        if platform[:platform] == :watir
          require 'page-object/platforms/watir_table_row'
          self.class.send :include, PageObject::Platforms::WatirTableRow
        elsif platform[:platform] == :selenium
          require 'page-object/platforms/selenium_table_row'
          self.class.send :include, PageObject::Platforms::SeleniumTableRow
        else
          raise ArgumentError, "expect platform to be :watir or :selenium"          
        end
      end
    end
  end
end