require 'watir-webdriver/extensions/select_text'

module PageObject
  module Platforms
    #
    # Watir implementation of the common functionality found across all elements
    #
    module WatirWebDriver
      module Element

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
        # Get the html for the element
        #
        # @return [String]
        #
        def html
          element.html
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
          cls.new(parent, :platform => @platform.class::PLATFORM_NAME)
        end

        #
        # Set the focus to the current element
        #
        def focus
          element.focus
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
          element.wait_until_present(timeout)
          self
        end

        #
        # Waits until the element is not present
        #
        # @param [Integer] (defaults to: 5) seconds to wait before
        # timing out
        #
        def when_not_present(timeout=::PageObject.default_element_wait)
          element.wait_while_present(timeout)
        end

        #
        # Waits until the element is visible
        #
        # @param [Integer] (defaults to: 5) seconds to wait before timing out
        #
        def when_visible(timeout=::PageObject.default_element_wait)
          Object::Watir::Wait.until(timeout, "Element was not visible in #{timeout} seconds") do
            visible?
          end
          self
        end

        #
        # Waits until the element is not visible
        #
        # @param [Integer] (defaults to: 5) seconds to wait before timing out
        #
        def when_not_visible(timeout=::PageObject.default_element_wait)
          Object::Watir::Wait.while(timeout, "Element still visible after #{timeout} seconds") do
            visible?
          end
          self
        end

        #
        # Waits until the block returns true
        #
        # @param [Integer] (defaults to: 5) seconds to wait before timing out
        # @param [String] the message to display if the event timeouts
        # @param the block to execute when the event occurs
        #
        def wait_until(timeout=::PageObject.default_element_wait, message=nil, &block)
          Object::Watir::Wait.until(timeout, message, &block)
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
      end
    end
  end
end
