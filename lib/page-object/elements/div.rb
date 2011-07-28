module PageObject
  module Elements
    class Div < Element
  
      protected
      
      def self.watir_finders
        [:class, :id, :text, :index, :xpath]
      end
      
      def self.selenium_finders
        [:class, :id, :name, :text, :xpath, :index]
      end
      
    end
  end
end