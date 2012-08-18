module PageObject
  module Elements
    class Video < Media

      def height
        height = attribute(:height)
        return height.to_i if height
      end

      def width
        width = attribute(:width)
        return width.to_i if width
      end
      
    end
    ::PageObject::Elements.type_to_class[:video] = ::PageObject::Elements::Video
  end
end
