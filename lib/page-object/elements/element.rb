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

      def initialize(element, platform)
        @element = element
        @platform = PageObject::Platforms::Watir::PageObject.new(@element)
      end

      #
      # return true if the element is not enabled
      #
      def disabled?
        not enabled?
      end


      def inspect
        element.inspect
      end

      #
      # retrieve the class name for an element
      #
      def class_name
        attribute 'class'
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
        timed_loop(timeout) do |element|
          element.visible?
        end
      end

      #
      # Keeps checking until the element exists
      #
      # @param [Integer] (defaults to: 5) seconds to wait before timing out
      #
      def check_exists(timeout=::PageObject.default_element_wait)
        timed_loop(timeout) do |element|
          element.exists?
        end
      end

      #
      # return true if an element is visible
      #
      # def visible?
      #   element.present?
      # end

      #
      # compare this element to another to determine if they are equal
      #
      def ==(other)
        other.is_a? self.class and element == other.element
      end

      #
      # Get the value of a the given attribute of the element.  Will
      # return the current value, even if this has been modified
      # after the page has been loaded. More exactly, this method
      # will  return the value of the given attribute, unless that
      # attribute is not present, in which case the value of the
      # property with the same name is returned. If neither value is
      # set, nil is returned. The "style" attribute is converted as
      # best can be to a text representation with a trailing
      # semi-colon. The following are deemed to be "boolean"
      # attributes, and will return either "true" or "false":
      #
      # async, autofocus, autoplay, checked, compact, complete,
      # controls, declare, defaultchecked, defaultselected, defer,
      # disabled, draggable, ended, formnovalidate, hidden, indeterminate,
      # iscontenteditable, ismap, itemscope, loop, multiple, muted,
      # nohref, noresize, noshade, novalidate, nowrap, open, paused,
      # pubdate, readonly, required, reversed, scoped, seamless, seeking,
      # selected, spellcheck, truespeed, willvalidate
      #
      # Finally, the following commonly mis-capitalized
      # attribute/property names are evaluated as expected:
      #
      # class, readonly
      #
      # @param [String]
      #   attribute name
      # @return [String,nil]
      #   attribute value
      #
      def attribute(attribute_name)
        element.attribute_value attribute_name
      end

      #
      # find the parent element
      #
      def parent
        parent = element.parent
        type = element.type if parent.tag_name.to_sym == :input
        cls = ::PageObject::Elements.element_class_for(parent.tag_name, type)
        cls.new(parent, :platform => :watir)
      end

      #
      # Waits until the element is present
      #
      # @param [Integer] (defaults to: 5) seconds to wait before timing out
      #
      def when_present(timeout=::PageObject.default_element_wait)
        element.wait_until(timeout: timeout, message: "Element not present in #{timeout} seconds", &:present?)
        self
      end

      #
      # Waits until the element is not present
      #
      # @param [Integer] (defaults to: 5) seconds to wait before
      # timing out
      #
      def when_not_present(timeout=::PageObject.default_element_wait)
        element.wait_while(timeout: timeout, message: "Element still present in #{timeout} seconds", &:present?)
      end

      #
      # Waits until the element is visible
      #
      # @param [Integer] (defaults to: 5) seconds to wait before timing out
      #
      def when_visible(timeout=::PageObject.default_element_wait)
        when_present(timeout)
        element.wait_until(timeout: timeout, message: "Element not visible in #{timeout} seconds", &:visible?)
        self
      end

      #
      # Waits until the element is not visible
      #
      # @param [Integer] (defaults to: 5) seconds to wait before timing out
      #
      def when_not_visible(timeout=::PageObject.default_element_wait)
        when_present(timeout)
        element.wait_while(timeout: timeout, message: "Element still visible after #{timeout} seconds", &:visible?)
      end

      #
      # Waits until the block returns true
      #
      # @param [Integer] (defaults to: 5) seconds to wait before timing out
      # @param [String] the message to display if the event timeouts
      # @param the block to execute when the event occurs
      #
      def wait_until(timeout=::PageObject.default_element_wait, message=nil, &block)
        element.wait_until(timeout: timeout, message: message, &block)
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

      protected

      def to_ary
        nil
      end

      private

      def timed_loop(timeout)
        end_time = ::Time.now + timeout
        until ::Time.now > end_time
          result = yield(self)
          return result if result
          sleep 0.5
        end
        false
      end

    end
  end
end
