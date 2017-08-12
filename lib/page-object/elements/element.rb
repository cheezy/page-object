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
      def parent(opt = {})
        parent = element.parent(opt)
        type = element.type if parent.tag_name.to_sym == :input
        cls = ::PageObject::Elements.element_class_for(parent.tag_name, type)
        cls.new(parent.to_subtype)
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
