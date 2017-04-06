require 'page-object/elements'
require 'page-object/platforms/watir/page_object'

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
        define_accessors(Accessors, widget_tag, widget_class)
        define_nested_elements(Elements::Element, widget_tag)
        define_locators(PageObject, widget_tag)

        PageObject::Platforms::Watir::PageObject.define_widget_accessors(widget_tag, widget_class, base_element_tag)
      end
    end

    private

    def self.define_accessors(base, widget_tag, widget_class)
      accessors_module = Module.new do
        define_method widget_tag do |name, *identifier_args, &block|
          
          identifier = identifier_args.first
          identifier = {:index => 0} if identifier.nil?
          
          define_method("#{name}_element") do
            return call_block(&block) if block
            platform.send("#{widget_tag}_for", identifier.clone)
          end
          define_method("#{name}?") do
            return call_block(&block).exists? if block
            platform.send("#{widget_tag}_for", identifier.clone).exists?
          end
          if widget_class.respond_to? :accessor_methods
            widget_class.accessor_methods(self, name)
          end
        end
        define_method widget_class.plural_form do |name, *identifier_args, &block|
          define_method("#{name}_elements") do
            return call_block(&block) unless block.nil?
            platform_method = "#{widget_tag.to_s}s_for"
            platform.send platform_method, (identifier_args.first ? identifier_args.first.clone : {})
          end
        end
      end

      base.send(:include, accessors_module)
    end

    def self.define_nested_elements(base, widget_tag)
      define_singular_nested_accessor(base, widget_tag)
      define_multiple_nested_accessor(base, widget_tag)
    end

    def self.define_multiple_nested_accessor(base, widget_tag)
      base.send(:define_method, "#{widget_tag}_elements") do |*args|
        identifier = args[0] ? args[0] : {}
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
