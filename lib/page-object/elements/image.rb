module PageObject
  module Elements
    class Image < Element

      #
      # Return the width of the image.
      #
      def width
        element.width
      end

      #
      # Return the height of the image
      #
      def height
        element.height
      end

      protected

      def self.watir_finders
        super + [:alt, :src]
      end

      def self.selenium_finders
        super + [:alt, :src, :css]
      end

    end

    ::PageObject::Elements.tag_to_class[:img] = ::PageObject::Elements::Image
    
  end
end
