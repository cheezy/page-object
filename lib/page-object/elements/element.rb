require 'page-object/nested_elements'
require 'watir/extensions/select_text'

module PageObject
  module Elements
    #
    # Contains functionality that is common across all elements.
    #
    # @see PageObject::Platforms::WatirWebDriver::Element for the Watir version of all common methods
    #
    class Element
      include ::PageObject::NestedElements

      attr_reader :element

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      #
      # click the element
      #
      def click
        element.click
      end

      #
      # return true if the element is enabled
      #
      def enabled?
        element.enabled?
      end

      #
      # return true if the element is not enabled
      #
      def disabled?
        not enabled?
      end

      #
      # return true if the element is stale (no longer attached
      # to the DOM)
      #
      def stale?
        element.stale?
      end

      #
      # get the value of the given CSS property
      #
      def style(property = nil)
        element.style property
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
            gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
            gsub(/([a-z\d])([A-Z])/,'\1_\2').
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
      def visible?
        element.present?
      end

      #
      # return true if an element exists
      #
      def exists?
        element.exists?
      end

      #
      # flash the element by temporarily changing the background color
      #
      def flash
        element.flash
      end

      #
      # Get the text for the element
      #
      # @return [String]
      #
      def text
        element.text
      end

      #
      # Returns the html for the element
      #
      # @return [String]
      #
      def html
        element.html
      end

      #
      # Returns the outer html for the element
      #
      # @return [String]
      #
      def outer_html
        element.outer_html
      end

      #
      # Returns the inner html for the element
      #
      # @return [String]
      #
      def inner_html
        element.inner_html
      end

      #
      # Get the value of this element
      #
      # @return [String]
      #
      def value
        element.value
      end

      #
      # compare this element to another to determine if they are equal
      #
      def ==(other)
        other.is_a? self.class and element == other.element
      end

      #
      # Get the tag name of this element
      #
      # @return [String]
      #
      def tag_name
        element.tag_name
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
      # Fire the provided event on the current element
      #
      def fire_event(event_name)
        element.fire_event(event_name)
      end

      #
      # hover over the element
      #
      def hover
        element.hover
      end

      #
      # double click the element
      #
      def double_click
        element.double_click
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
      # Set the focus to the current element
      #
      def focus
        element.focus
      end

      #
      # return true if an element is focused
      #
      def focused?
        element.focused?
      end

      #
      # Select the provided text
      #
      def select_text(text)
        element.select_text text
      end

      #
      # Right click on an element
      #
      def right_click
        element.right_click
      end

      #
      # Waits until the element is present
      #
      # @param [Integer] (defaults to: 5) seconds to wait before timing out
      #
      def when_present(timeout=::PageObject.default_element_wait)
        element.wait_until(timeout: timeout, message: "Element not present in #{timeout} seconds",  &:present?)
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
        element.wait_until(timeout: timeout, message: "Element not visible in #{timeout} seconds", &:visible?)
        self
      end

      #
      # Waits until the element is not visible
      #
      # @param [Integer] (defaults to: 5) seconds to wait before timing out
      #
      def when_not_visible(timeout=::PageObject.default_element_wait)
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
      # Send keystrokes to this element
      #
      # @param [String, Symbol, Array]
      #
      # Examples:
      #
      #     element.send_keys "foo"                     #=> value: 'foo'
      #     element.send_keys "tet", :arrow_left, "s"   #=> value: 'test'
      #     element.send_keys [:control, 'a'], :space   #=> value: ' '
      #
      # @see Selenium::WebDriver::Keys::KEYS
      #
      def send_keys(*args)
        element.send_keys(*args)
      end

      #
      # clear the contents of the element
      #
      def clear
        element.clear
      end

      #
      # get the id of the element
      #
      def id
        element.id
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
      def self.watir_identifier_for identifier
        if should_build_watir_xpath(identifier)
          how = :xpath
          what = build_xpath_for(identifier)
          return how => what
        end
        all_identities = {}
        identifier.each do |key, value|
          each = {key => value}
          ident = identifier_for each, watir_finders, watir_mapping
          all_identities[ident.keys.first] = ident.values.first
        end
        all_identities
      end

      # @private
      # delegate calls to driver element
      def method_missing(*args, &block)
        m = args.shift
        element.send m, *args, &block
      end

      protected

      def self.should_build_watir_xpath identifier
        ['table', 'span', 'div', 'td', 'li', 'ul', 'ol', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'label', 'area', 'canvas', 'audio', 'video', 'b', 'i'].include? identifier[:tag_name] and identifier[:name]
      end

      def self.build_xpath_for identifier
        tag_locator = identifier.delete(:tag_name)
        idx = identifier.delete(:index)
        if tag_locator == 'input' and identifier[:type] == 'submit'
          identifier.delete(:type)
          btn_ident = identifier.clone
          if btn_ident[:value]
            btn_ident[:text] = btn_ident[:value]
            btn_ident.delete(:value)
          end
          xpath = ".//button"
          xpath << "[#{attribute_expression(btn_ident)}]" unless btn_ident.empty?
          xpath = "(#{xpath})[#{idx+1}]" if idx
          identifier[:type] = %w[button reset submit image]
          xpath << " | .//input"
        else
          xpath = ".//#{tag_locator}"
        end
        xpath << "[#{attribute_expression(identifier)}]" unless identifier.empty?
        xpath = "(#{xpath})[#{idx+1}]" if idx
        xpath
      end

      def self.attribute_expression(identifier)
        identifier.map do |key, value|
          if value.kind_of?(Array)
            "(" + value.map { |v| equal_pair(key, v) }.join(" or ") + ")"
          else
            equal_pair(key, value)
          end
        end.join(" and ")
      end

      def self.equal_pair(key, value)
        if key == :label
          "@id=//label[normalize-space()=#{xpath_string(value)}]/@for"
        else
          "#{lhs_for(key)}=#{xpath_string(value)}"
        end
      end

      def self.lhs_for(key)
        case key
          when :text, 'text'
            'normalize-space()'
          when :href
            'normalize-space(@href)'
          else
            "@#{key.to_s.gsub("_", "-")}"
        end
      end

      def self.xpath_string(value)
        if value.include? "'"
          parts = value.split("'", -1).map { |part| "'#{part}'" }
          string = parts.join(%{,"'",})
          "concat(#{string})"
        else
          "'#{value}'"
        end
      end

      def self.identifier_for identifier, find_by, find_by_mapping
        how, what = identifier.keys.first, identifier.values.first
        return how => what if find_by.include? how or how == :tag_name
        return find_by_mapping[how] => what if find_by_mapping[how]
        identifier
      end

      def self.watir_finders
        [:class, :id, :index, :name, :xpath]
      end

      def self.watir_mapping
        {}
      end

      def include_platform_for platform
        platform_information = PageObject::Platforms.get
        raise ArgumentError,"Expected hash with at least a key :platform for platform information! (#{platform.inspect})" unless platform.class == Hash && platform.has_key?(:platform)
        platform_name = platform[:platform]

        raise ArgumentError, "Unknown platform #{platform_name}! Expect platform to be one of the following: #{platform_information.keys.inspect}" unless platform_information.keys.include?(platform_name)
        base_platform_class = "#{platform_information[platform_name]}::"

        @platform = constantize_classname(base_platform_class+ "PageObject").new(@element)
      end

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

      def constantize_classname name
        name.split("::").inject(Object) { |k,n| k.const_get(n) }
      end

    end
  end
end
