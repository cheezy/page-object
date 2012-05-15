require 'watir-webdriver/atoms'

module PageObject
  module Platforms
    #
    # Selenium implementation of the common functionality found across all elements
    #
    module SeleniumWebDriver
      module Element
        include Watir::Atoms

        #
        # return true if an element is visible
        #
        def visible?
          element.displayed?
        end

        #
        # return true if an element exists
        #
        def exists?
          not element.nil?
        end

        #
        # flash the element by temporarily changing the background color
        #
        def flash
          original_color = attribute('backgroundColor')
          bridge = element.instance_variable_get(:@bridge)
          10.times do |n|
            color = (n % 2 == 0) ? 'red' : original_color
            bridge.executeScript("arguments[0].style.backgroundColor = '#{color}'", element)
          end
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
        # Get the value of this element
        #
        # @return [String]
        #
        def value
          element.attribute('value')
        end

        #
        # compare this element to another to determine if they are equal
        #
        def ==(other)
          element == other.element
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
          element.attribute attribute_name
        end

        #
        # Fire the provided event on the current element
        #
        def fire_event(event_name)
          event_name = event_name.to_s.sub(/^on/, '').downcase
          script = "return (%s).apply(null, arguments)" % ATOMS.fetch(:fireEvent)
          bridge = element.instance_variable_get(:@bridge)
          bridge.executeScript(script, element, event_name)
        end

        #
        # find the parent element
        #
        def parent
          script = "return (%s).apply(null, arguments)" % ATOMS.fetch(:getParentElement)
          bridge = element.instance_variable_get(:@bridge)
          parent = bridge.executeScript(script, element)
          type = element.attribute(:type).to_s.downcase if parent.tag_name.to_sym == :input
          cls = ::PageObject::Elements.element_class_for(parent.tag_name, type)
          cls.new(parent, :platform => :selenium_webdriver)
        end

        #
        # Set the focus to the current element
        #
        def focus
          bridge = element.instance_variable_get(:@bridge)
          bridge.executeScript("return arguments[0].focus()", element)
        end

        #
        # Click this element
        #
        def right_click
          element.context_click
        end

        #
        # Waits until the element is present
        #
        # @param [Integer] (defaults to: 5) seconds to wait before timing out
        #
        def when_present(timeout=::PageObject.default_element_wait)
          wait = Object::Selenium::WebDriver::Wait.new({:timeout => timeout, :message => "Element not present in #{timeout} seconds"})
          wait.until do
            self.exists?
          end
          self
        end

        #
        # Waits until the element is not present
        #
        # @param [Integer] (defaults to: 5) seconds to wait before
        # timing out
        #
        def when_not_present(timeout=::PageObject.default_element_wait)
          wait = Object::Selenium::WebDriver::Wait.new({:timeout => timeout, :message => "Element still present in #{timeout} seconds"})
          wait.until do
            not_present = false
            begin
              not_present = false if element and element.displayed?
            rescue Selenium::WebDriver::Error::ObsoleteElementError
              not_present = true
            end
            not_present
          end
        end

        #
        # Waits until the element is visible
        #
        # @param [Integer] (defaults to: 5) seconds to wait before timing out
        #
        def when_visible(timeout=::PageObject.default_element_wait)
          wait = Object::Selenium::WebDriver::Wait.new({:timeout => timeout, :message => "Element not visible in #{timeout} seconds"})
          wait.until do
            self.visible?
          end
          self
        end

        #
        # Waits until the element is not visible
        #
        # @param [Integer] (defaults to: 5) seconds to wait before timing out
        #
        def when_not_visible(timeout=::PageObject.default_element_wait)
          wait = Object::Selenium::WebDriver::Wait.new({:timeout => timeout, :message => "Element still visible in #{timeout} seconds"})
          wait.until do
            not self.visible?
          end
          self
        end

        #
        # Waits until the block returns true
        #
        # @param [Integer] (defaults to: 5) seconds to wait before timing out
        # @param [String] the message to display if the event timeouts
        # @param the block to execute when the event occurrs
        #
        def wait_until(timeout=::PageObject.default_element_wait, message=nil, &block)
          wait = Object::Selenium::WebDriver::Wait.new({:timeout => timeout, :message => message})
          wait.until &block
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
      end
    end
  end
end
