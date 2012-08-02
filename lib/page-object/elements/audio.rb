
module PageObject
  module Elements
    class Audio < Element

      def autoplay?
        attribute(:autoplay)
      end

      def has_controls?
        attribute(:controls)
      end

      def paused?
        attribute(:paused)
      end

      def duration
        duration = attribute(:duration)
        return duration.to_f if duration
      end

      def volume
        volume = attribute(:volume)
        return volume.to_i if volume
      end
      
    end
    ::PageObject::Elements.type_to_class[:audio] = ::PageObject::Elements::Audio
  end
end
