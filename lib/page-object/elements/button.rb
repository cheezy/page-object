module PageObject
  module Elements
    class Button < Element

      protected
      
      def self.watir_finders
        super + [:text]
      end
    end
  end
end