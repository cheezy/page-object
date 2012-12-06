require 'watir-webdriver/extensions/alerts'
require 'page-object/elements'
require 'page-object/platforms/selenium_webdriver/page_object'
require 'page-object/platforms/watir_webdriver/page_object'


module Widgets

  def self.included(base)
    widget_tag = "gxt_table"
    base::Elements.send(:include, WidgetElements)
    define_accessors(base::Accessors, widget_tag)
    define_nested_elements(base::Elements::Element, widget_tag)
    define_locators(base, widget_tag)
    define_selenium_accessors(base::Platforms::SeleniumWebDriver::PageObject, widget_tag)
    define_watir_accessors(base::Platforms::WatirWebDriver::PageObject, widget_tag)
  end

  def self.register_widget(widget_tag, widget_class)
    base::Elements.send(:include, widget_class)
    define_accessors(base::Accessors, widget_tag)
    define_nested_elements(base::Elements::Element, widget_tag)
    define_locators(base, widget_tag)
    define_selenium_accessors(base::Platforms::SeleniumWebDriver::PageObject, widget_tag)
    define_watir_accessors(base::Platforms::WatirWebDriver::PageObject, widget_tag)
  end

  @private
  def self.define_accessors(base, widget_tag)
    accessors_module = Module.new {class_eval "def #{widget_tag}(name, identifier={}, &block)
          identifier={:index=>0} if identifier.empty?
          define_method(\"\#{name}_element\") do
            return call_block(&block) if block_given?
            platform.#{widget_tag}_for(identifier.clone)
          end
          define_method(\"\#{name}?\") do
            return call_block(&block).exists? if block_given?
            platform.#{widget_tag}_for(identifier.clone).exists?
          end
        alias_method \"\#{name}_table\".to_sym, \"\#{name}_element\".to_sym
        end"   }

    base.send(:include,accessors_module)
  end

  def self.define_watir_accessors(base, widget_tag)
    #
    # platform method to retrieve a table element
    # See WidgetAccessors#table
    #
    base.send(:define_method,"#{widget_tag}_for") do |identifier|
      find_watir_element("div(identifier)", PageObject::Elements::GxtTable, identifier, 'div')
    end

    #
    # platform method to retrieve an array of table elements
    #
    base.send(:define_method,"#{widget_tag}s_for") do |identifier|
      find_watir_elements("div(identifier)", PageObject::Elements::GxtTable, identifier, 'div')
    end

  end

  def self.define_selenium_accessors(base, widget_tag)
    base.send(:define_method, "#{widget_tag}_for") do |identifier|
      find_selenium_element(identifier, PageObject::Elements::GxtTable, 'div')
    end

    #
    # platform method to retrieve all table elements
    #
    base.send(:define_method, "#{widget_tag}s_for") do |identifier|
      find_selenium_elements(identifier, PageObject::Elements::GxtTable, 'div')
    end
  end

  def self.define_nested_elements(base, widget_tag)
    base.send(:define_method,"#{widget_tag}_element") do |identifier={}|
      identifier={:index=>0} if identifier.empty?
      @platform.send("#{widget_tag}_for", identifier.clone)
    end

    base.send(:define_method,"#{widget_tag}_elements") do |identifier={}|
      identifier={:index=>0} if identifier.empty?
      @platform.send("#{widget_tag}s_for", identifier.clone)
    end
  end


  def self.define_locators(base, widget_tag)
    base.send(:define_method,"#{widget_tag}_element") do |identifier={}|
      identifier={:index=>0} if identifier.empty?
      platform.send("#{widget_tag}_for", identifier.clone)
    end

    base.send(:define_method, "#{widget_tag}_elements") do |identifier={} |
        platform.send("#{widget_tag}s_for", identifier.clone)
    end
  end
end


