module PageObject
  module Elements
    class HiddenField < Element

      def click
        raise "click is not available on hidden field element with Selenium or Watir"
      end

      protected

      def self.watir_finders
        super + [:tag_name, :text, :value]
      end

      def self.watir_mapping
        super.merge({:css => :tag_name})
      end

      def self.selenium_finders
        super + [:css, :value]
      end

      def self.selenium_mapping
        super.merge({:tag_name => :css})
      end
    end
  end
end
