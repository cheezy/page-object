
module PageObject
  module Elements
    class Area < Element

      #
      # return the coordinates of the area
      #
      def coords
        attribute(:coords)
      end

      #
      # return the shape of the area
      #
      def shape
        attribute(:shape)
      end

      #
      # return the href of the area
      #
      def href
        attribute(:href)
      end

    end

    ::PageObject::Elements.type_to_class[:area] = ::PageObject::Elements::Area
  end
end
