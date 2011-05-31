
module PageObject
  module Platforms
    module SeleniumElement
      
      #
      # return true if an element is visible
      #
      def visible?
        @element.displayed?
      end
    
      #
      # return true if an element exists
      #
      def exists?
        nil != @element
      end

      #
      # Get the text for the element
      #
      # @return [String]
      #
      def text
        @element.text
      end

      #
      # Get the value of this element
      #
      # @return [String]
      #
      def value
        @element.attribute('value')
      end
      
      #
      # compare this element to another to determine if they are equal
      #
      def ==(other)
        @element == other.element
      end

      #
      # Get the tag name of this element
      #
      # @return [String]
      #
      def tag_name
        @element.tag_name
      end
      
      #
      # Get the value of a the given attribute of the element. Will return the current value, even if
      # this has been modified after the page has been loaded. More exactly, this method will return
      # the value of the given attribute, unless that attribute is not present, in which case the
      # value of the property with the same name is returned. If neither value is set, nil is
      # returned. The "style" attribute is converted as best can be to a text representation with a
      # trailing semi-colon. The following are deemed to be "boolean" attributes, and will
      # return either "true" or "false":
      #
      # async, autofocus, autoplay, checked, compact, complete, controls, declare, defaultchecked,
      # defaultselected, defer, disabled, draggable, ended, formnovalidate, hidden, indeterminate,
      # iscontenteditable, ismap, itemscope, loop, multiple, muted, nohref, noresize, noshade, novalidate,
      # nowrap, open, paused, pubdate, readonly, required, reversed, scoped, seamless, seeking,
      # selected, spellcheck, truespeed, willvalidate
      #
      # Finally, the following commonly mis-capitalized attribute/property names are evaluated as
      # expected:
      #
      # class, readonly
      #
      # @param [String]
      #   attribute name
      # @return [String,nil]
      #   attribute value
      #
      def attribute(attribute_name)
        @element.attribute attribute_name
      end
    end
  end
end