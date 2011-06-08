module PageObject
  module Elements
    class TextArea < Element

      protected
      
      def self.watir_finders
        super + [:tag_name]
      end
      
      def self.watir_mapping
        super.merge({:css => :tag_name})
      end
      
      def self.selenium_finders
        super + [:css]
      end
      
      def self.selenium_mapping
        super.merge({:tag_name => :css})
      end
    end
  end
end