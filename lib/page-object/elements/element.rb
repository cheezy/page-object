require 'page-object/nested_elements'
require 'watir/extensions/select_text'

module PageObject
  module Elements
    #
    # Contains functionality that is common across all elements.
    #
    # @see PageObject::Platforms::Watir::Element for the Watir version of all common methods
    #
    class Element
      include ::PageObject::NestedElements

      attr_reader :element

      def initialize(element)
        @element = element
        @platform = PageObject::Platforms::Watir::PageObject.new(@element)
      end

      #
      # return true if the element is not enabled
      #
      def disabled?
        not enabled?
      end

      #
      # returns vallue of specified attribute
      #
      def attribute(*args)
        attribute_value(*args)
      end

      #
      # specify plural form of element
      #
      def self.plural_form
        "#{self.to_s.split('::')[-1].
            gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
            gsub(/([a-z\d])([A-Z])/, '\1_\2').
            tr("-", "_").
            downcase}s"
      end

      #
      # Keeps checking until the element is visible
      #
      # @param [Integer] (defaults to: 5) seconds to wait before timing out
      #
      def check_visible(timeout=::PageObject.default_element_wait)
        wait_until(timeout: timeout, message: "Element not visible in #{timeout} seconds", &:present?)
      end
      alias_method :when_present, :check_visible
      alias_method :when_visible, :check_visible

      #
      # Keeps checking until the element exists
      #
      # @param [Integer] (defaults to: 5) seconds to wait before timing out
      #
      def check_exists(timeout=::PageObject.default_element_wait)
        wait_until(timeout: timeout, &:exist?)
      end

      #
      # compare this element to another to determine if they are equal
      #
      def ==(other)
        other.is_a? self.class and element == other.element
      end

      #
      # find the parent element
      #
      def parent
        parent = element.parent
        type = element.type if parent.tag_name.to_sym == :input
        cls = ::PageObject::Elements.element_class_for(parent.tag_name, type)
        cls.new(parent)
      end

      #
      # Waits until the element is not present
      #
      # @param [Integer] (defaults to: 5) seconds to wait before
      # timing out
      #
      def when_not_present(timeout=::PageObject.default_element_wait)
        element.wait_while_present(timeout: timeout)
      end

      # Waits until the element is not visible
      #
      # @param [Integer] (defaults to: 5) seconds to wait before timing out
      #
      def when_not_visible(timeout=::PageObject.default_element_wait)
        when_present(timeout)
        element.wait_while(timeout: timeout, message: "Element still visible after #{timeout} seconds", &:visible?)
      end

      #
      # Scroll until the element is viewable
      #
      def scroll_into_view
        element.wd.location_once_scrolled_into_view
      end

      #
      # location of element (x, y)
      #
      def location
        element.wd.location
      end

      #
      # size of element (width, height)
      #
      def size
        element.wd.size
      end

      #
      # Get height of element
      #
      def height
        element.wd.size['height']
      end

      #
      # Get width of element
      #
      def width
        element.wd.size['width']
      end

      #
      # Get centre coordinates of element
      #
      def centre
        location = element.wd.location
        size = element.wd.size
        {'y' => (location['y'] + (size['height']/2)), 'x' => (location['x'] + (size['width']/2))}
      end

      # @private
      # delegate calls to driver element
      def method_missing(*args, &block)
        m = args.shift
        element.send m, *args, &block
      end

      def respond_to_missing?(m,*args)
        element.respond_to?(m) || super
      end

    end
  end
end
