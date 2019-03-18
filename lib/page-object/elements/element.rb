require 'page-object/nested_elements'

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
      # return true if the element exists and is visible
      #
      def present?
        element.present?
      end

      def drag_and_drop_on(droppable)
        droppable_native = droppable.kind_of?(PageObject::Elements::Element) ? droppable.element : droppable
        element.drag_and_drop_on(droppable_native)
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
          element.present?
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
        pageobject_wrapper(parent)
      end

      #
      # Return the element that exists at the same level of the DOM
      # immediately prior to this element
      #
      def preceding_sibling(opt = {})
        sibling = element.preceding_sibling(opt)
        pageobject_wrapper(sibling)
      end

      #
      # Return the element that exists at the same level of the DOM
      # immediately after this element
      #
      def following_sibling(opt={})
        sibling = element.following_sibling(opt)
        pageobject_wrapper(sibling)
      end

      #
      # Return all elements that are direct children of this element's parent
      #
      def siblings(opt={})
        siblings = element.siblings(opt)
        siblings.collect {|sibling| pageobject_wrapper(sibling)}
      end

      #
      # Return all elements that are children of this element
      #
      def children(opt={})
        children = element.children(opt)
        children.collect {|child| pageobject_wrapper(child)}
      end

      #
      # Return all elements that exist at the same level of the DOM
      # immediately prior to this element
      #
      def preceding_siblings(opt={})
        siblings = element.preceding_siblings(opt)
        siblings.collect {|sibling| pageobject_wrapper(sibling)}
      end

      #
      # Return all elements that exist at the same level of the DOM
      # immediately after this element
      #
      def following_siblings(opt={})
        siblings = element.following_siblings(opt)
        siblings.collect {|sibling| pageobject_wrapper(sibling)}
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
      alias_method :when_visible, :when_present

      #
      # Waits until the element is not present
      #
      # @param [Integer] (defaults to: 5) seconds to wait before
      # timing out
      #
      def when_not_present(timeout=::PageObject.default_element_wait)
        element.wait_while(timeout: timeout, message: "Element still present in #{timeout} seconds", &:present?)
      end
      alias_method :when_not_visible, :when_not_present

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

      def name
        element.attribute(:name)
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

      def pageobject_wrapper(watir_object)
        type = element.type if watir_object.tag_name.to_sym == :input
        cls = ::PageObject::Elements.element_class_for(watir_object.tag_name, type)
        cls.new(watir_object.to_subtype)
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
