module PageObject
  module Elements
    class Media < Element

      def has_controls?
        attribute(:controls)
      end

    end
  end
end
