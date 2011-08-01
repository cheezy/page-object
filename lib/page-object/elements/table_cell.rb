module PageObject
  module Elements
    class TableCell < Element

      protected

      def self.watir_finders
        super + [:text]
      end

      def self.selenium_finders
        super + [:text]
      end

    end
  end
end