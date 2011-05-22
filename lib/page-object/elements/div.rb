module PageObject
  module Elements
    class Div < Element
  
      protected
      
      def self.watir_finders
        [:class, :id, :index, :xpath]
      end
    end
  end
end