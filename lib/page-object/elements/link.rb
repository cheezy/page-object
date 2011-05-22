module PageObject
  module Elements
    class Link < Element
      
      
      protected
      
      def self.watir_finders
        super + [:href, :text]
      end
      
      def self.watir_mapping
        super.merge({ :link => :text, :link_text => :text })
      end
      
      def self.selenium_finders
        super + [:link, :link_text]
      end
      
      def self.selenium_mapping
        super.merge(:text => :link_text)
      end

    end
  end
end