module PageObject
  module Elements
    class << self

      #
      # method to return the collection of tag_name to class mappings
      #
      def tag_to_class
        @tag_to_class ||= {}
      end

      def type_to_class
        @type_to_class ||= {}
      end

      #
      # method to return the element for a tag_name
      #
      def element_class_for(tag_name, type=nil)
        return type_to_class[type.to_sym] if type
        tag_to_class[tag_name.to_sym] || ::PageObject::Elements::Element
      end

    end
  end
end


require 'page-object/elements/element'
require 'page-object/elements/link'
require 'page-object/elements/text_field'
require 'page-object/elements/select_list'
require 'page-object/elements/check_box'
require 'page-object/elements/button'
require 'page-object/elements/radio_button'
require 'page-object/elements/div'
require 'page-object/elements/table'
require 'page-object/elements/table_cell'
require 'page-object/elements/table_row'
require 'page-object/elements/span'
require 'page-object/elements/image'
require 'page-object/elements/hidden_field'
require 'page-object/elements/form'
require 'page-object/elements/text_area'
require 'page-object/elements/list_item'
require 'page-object/elements/unordered_list'
require 'page-object/elements/ordered_list'
require 'page-object/elements/option'
require 'page-object/elements/heading'
require 'page-object/elements/paragraph'
require 'page-object/elements/label'
require 'page-object/elements/file_field'
require 'page-object/elements/area'
require 'page-object/elements/canvas'
require 'page-object/elements/media'
require 'page-object/elements/audio'
require 'page-object/elements/video'
require 'page-object/elements/bold'
require 'page-object/elements/italic'


