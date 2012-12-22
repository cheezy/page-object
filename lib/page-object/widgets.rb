require 'page-object/elements'
require 'page-object/platforms/selenium_webdriver/page_object'
require 'page-object/platforms/watir_webdriver/page_object'

module PageObject
  module Widgets

    #
    # Module that allows for the registration of widget classes which extend the functionality of PageObject
    # Allows any classes which extend PageObject::Element to be used as PageObject elements.
    # This allows such widgets to be created using the defined tags.
    #
    # @param [Symbol] defines the symbol which will be used as an accessor name.
    # @param [Class] the widget class extending PageObject::Elements::Element
    # @param [Symbol] the symbol of the html element used when searching for this widget.
    #
    #
    def self.register_widget(widget_tag, widget_class, base_element_tag)
      if widget_class.ancestors.include? Elements::Element
        define_accessors(Accessors, widget_tag)
        define_nested_elements(Elements::Element, widget_tag)
        define_locators(PageObject, widget_tag)
        define_selenium_accessors(Platforms::SeleniumWebDriver::PageObject, widget_tag, widget_class, base_element_tag)
        define_watir_accessors(Platforms::WatirWebDriver::PageObject, widget_tag, widget_class, base_element_tag)
      end
    end

    @private

    def self.define_accessors(base, widget_tag)
      accessors_module = Module.new do
        class_eval "def #{widget_tag}(name, identifier={}, &block)
          identifier={:index=>0} if identifier.empty?
          define_method(\"\#{name}_element\") do
            return call_block(&block) if block_given?
            platform.#{widget_tag}_for(identifier.clone)
          end
          define_method(\"\#{name}?\") do
            return call_block(&block).exists? if block_given?
            platform.#{widget_tag}_for(identifier.clone).exists?
          end
        end"
      end

      base.send(:include, accessors_module)
    end

    def self.define_watir_accessors(base, widget_tag, widget_class, base_element_tag)
      define_singular_watir_accessor(base, base_element_tag, widget_class, widget_tag)
      define_multiple_watir_accessor(base, base_element_tag, widget_class, widget_tag)
    end

    def self.define_multiple_watir_accessor(base, base_element_tag, widget_class, widget_tag)
      base.send(:define_method, "#{widget_tag}s_for") do |identifier|
        find_watir_elements("#{base_element_tag}(identifier)", widget_class, identifier, base_element_tag)
      end
    end

    def self.define_singular_watir_accessor(base, base_element_tag, widget_class, widget_tag)
      base.send(:define_method, "#{widget_tag}_for") do |identifier|
        find_watir_element("#{base_element_tag}(identifier)", widget_class, identifier, base_element_tag)
      end
    end

    def self.define_selenium_accessors(base, widget_tag, widget_class, base_element_tag)
      define_singular_selenium_accessor(base, base_element_tag, widget_class, widget_tag)
      define_multiple_selenium_accessor(base, base_element_tag, widget_class, widget_tag)
    end

    def self.define_multiple_selenium_accessor(base, base_element_tag, widget_class, widget_tag)
      base.send(:define_method, "#{widget_tag}s_for") do |identifier|
        find_selenium_elements(identifier, widget_class, base_element_tag)
      end
    end

    def self.define_singular_selenium_accessor(base, base_element_tag, widget_class, widget_tag)
      base.send(:define_method, "#{widget_tag}_for") do |identifier|
        find_selenium_element(identifier, widget_class, base_element_tag)
      end
    end

    def self.define_nested_elements(base, widget_tag)
      define_singular_nested_accessor(base, widget_tag)
      define_multiple_nested_accessor(base, widget_tag)
    end

    def self.define_multiple_nested_accessor(base, widget_tag)
      base.send(:define_method, "#{widget_tag}_elements") do |*args|
        identifier = args[0] ? args[0] : {:index => 0}
        @platform.send("#{widget_tag}s_for", identifier.clone)
      end
    end

    def self.define_singular_nested_accessor(base, widget_tag)
      base.send(:define_method, "#{widget_tag}_element") do |*args|
        identifier = args[0] ? args[0] : {:index => 0}
        @platform.send("#{widget_tag}_for", identifier.clone)
      end
    end

    def self.define_locators(base, widget_tag)
      define_singular_locator(base, widget_tag)
      define_multiple_locator(base, widget_tag)
    end

    def self.define_multiple_locator(base, widget_tag)
      base.send(:define_method, "#{widget_tag}_elements") do |*args|
        identifier = args[0] ? args[0] : {}
        platform.send("#{widget_tag}s_for", identifier.clone)
      end
    end

    def self.define_singular_locator(base, widget_tag)
      base.send(:define_method, "#{widget_tag}_element") do |*args|
        identifier = args[0] ? args[0] : {:index => 0}
        platform.send("#{widget_tag}_for", identifier.clone)
      end
    end
  end
end
