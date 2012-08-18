
module PageObject
  module Elements
    class Media < Element

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

      def ended?
        attribute(:ended)
      end

      def seeking?
        attribute(:seeking)
      end

      def loop?
        attribute(:loop)
      end

      def muted?
        attribute(:muted)
      end
    end
  end
end
