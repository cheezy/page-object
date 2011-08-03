module PageObject
  module Elements
    class Span < Element

      protected

      def self.watir_finders
        [:class, :id, :index, :text, :xpath]
      end
      
      def self.selenium_finders
        [:class, :id, :name, :text, :xpath, :index]
      end
    end
  end
end