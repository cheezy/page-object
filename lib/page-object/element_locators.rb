module PageObject
  module  ElementLocators
    
    #
    # Finds a button
    #
    # @param [Hash] identifier how we find a button.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0} 
    #   which will find the first button.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :css => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir only
    #   * :value => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #   * :src => Watir and Selenium (image button only)
    #   * :alt => Watir and Selenium (image button only)
    #
    def button_element(identifier={:index => 0})
      platform.button_for(identifier.clone)
    end

    #
    # Finds all buttons that match the provided identifier
    #
    # @param [Hash] identifier how we find a button.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty 
    #   hash which will find all button elements.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :css => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir only
    #   * :value => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #   * :src => Watir and Selenium (image button only)
    #   * :alt => Watir and Selenium (image button only)
    #
    def button_elements(identifier={})
      platform.buttons_for(identifier.clone)
    end
    
    #
    # Finds a text field
    #
    # @param [Hash] identifier how we find a text field.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index=> 0} 
    #   which will find the first text field.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :css => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :tag_name => Watir and Selenium
    #   * :text => Watir only
    #   * :title => Watir and Selenium
    #   * :value => Watir only
    #   * :xpath => Watir and Selenium
    #
    def text_field_element(identifier={:index => 0})
      platform.text_field_for(identifier.clone)
    end
    
    #
    # Finds all text fields that match the provided identifier
    #
    # @param [Hash] identifier how we find a text field.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash 
    #   which will find all text field elements.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :css => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :tag_name => Watir and Selenium
    #   * :text => Watir only
    #   * :title => Watir and Selenium
    #   * :value => Watir only
    #   * :xpath => Watir and Selenium
    #
    def text_field_elements(identifier={})
      platform.text_fields_for(identifier.clone)
    end
    
    #
    # Finds a hidden field
    #
    # @param [Hash] identifier how we find a hidden field.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will find the first hidden field.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :css => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :tag_name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def hidden_field_element(identifier={:index => 0})
      platform.hidden_field_for(identifier.clone)
    end
    
    #
    # Finds all hidden fields that match the identifier
    #
    # @param [Hash] identifier how we find a hidden field.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty hash
    #   which will return all hidden fields.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :css => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :tag_name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def hidden_field_elements(identifier={})
      platform.hidden_fields_for(identifier.clone)
    end
    
    #
    # Finds a text area
    #
    # @param [Hash] identifier how we find a text area.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first text area.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :css => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :tag_name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def text_area_element(identifier={:index => 0})
      platform.text_area_for(identifier.clone)
    end
    
    #
    # Finds all text areas for the provided identifier
    #
    # @param [Hash] identifier how we find a text area.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty hash
    #   which will return all text areas.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :css => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :tag_name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def text_area_elements(identifier={})
      platform.text_areas_for(identifier.clone)
    end
    
    #
    # Finds a select list
    #
    # @param [Hash] identifier how we find a select list.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will select the first select list.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir only
    #   * :value => Watir only
    #   * :xpath => Watir and Selenium
    #
    def select_list_element(identifier={:index => 0})
      platform.select_list_for(identifier.clone)
    end
    
    #
    # Finds all select lists for the provided identifier
    #
    # @param [Hash] identifier how we find a select list.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash
    #   which will return all select lists.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir only
    #   * :value => Watir only
    #   * :xpath => Watir and Selenium
    #
    def select_list_elements(identifier={})
      platform.select_lists_for(identifier.clone)
    end
    
    #
    # Finds a link
    #
    # @param [Hash] identifier how we find a link.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will select the first link.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :css => Watir and Selenium
    #   * :href => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :link => Watir and Selenium
    #   * :link_text => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def link_element(identifier={:index => 0})
      platform.link_for(identifier.clone)
    end
    
    #
    # Find all links for the provided identifier
    #
    # @param [Hash] identifier how we find a link.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash
    #   which will return all links.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :css => Watir and Selenium
    #   * :href => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :link => Watir and Selenium
    #   * :link_text => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def link_elements(identifier={})
      platform.links_for(identifier.clone)
    end
    
    #
    # Finds a checkbox
    #
    # @param [Hash] identifier how we find a checkbox.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first checkbox.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def checkbox_element(identifier={:index => 0})
      platform.checkbox_for(identifier.clone)
    end

    #
    # Finds all checkbox elements for the provided identifier
    #
    # @param [Hash] identifier how we find a checkbox.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash
    #   which will return all checkboxes.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def checkbox_elements(identifier={})
      platform.checkboxes_for(identifier.clone)
    end

    #
    # Finds a radio button
    #
    # @param [Hash] identifier how we find a radio button.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first radio button.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def radio_button_element(identifier={:index => 0})
      platform.radio_button_for(identifier.clone)
    end

    #
    # Finds all radio button elements that match the provided identifier
    #
    # @param [Hash] identifier how we find a radio button.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash
    #   which will return all radio buttons.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def radio_button_elements(identifier={})
      platform.radio_buttons_for(identifier.clone)
    end

    #
    # Finds a div
    #
    # @param [Hash] identifier how we find a div.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first div.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def div_element(identifier={:index => 0})
      platform.div_for(identifier.clone)
    end

    #
    # Finds all divs that match the provided identifier
    #
    # @param [Hash] identifier how we find a div.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash
    #   which will return all divs.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def div_elements(identifier={})
      platform.divs_for(identifier.clone)
    end

    #
    # Finds a span
    #
    # @param [Hash] identifier how we find a span.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first span element.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def span_element(identifier={:index => 0})
      platform.span_for(identifier.clone)
    end
    
    #
    # Finds all span elements that match the provided identifier
    #
    # @param [Hash] identifier how we find a span.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash
    #   which will return all of the spans.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def span_elements(identifier={})
      platform.spans_for(identifier.clone)
    end
    
    #
    # Finds a table
    #
    # @param [Hash] identifier how we find a table.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first table.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def table_element(identifier={:index => 0})
      platform.table_for(identifier.clone)
    end

    #
    # Finds all tables that match the provided identifier
    #
    # @param [Hash] identifier how we find a table.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash
    #   which will return all tables.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def table_elements(identifier={})
      platform.tables_for(identifier.clone)
    end

    #
    # Finds a table cell
    #
    # @param [Hash] identifier how we find a cell.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first cell.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir only
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def cell_element(identifier={:index => 0})
      platform.cell_for(identifier.clone)
    end
    
    #
    # Finds all table cell elements that match the provided identifier
    #
    # @param [Hash] identifier how we find a cell.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash
    #   which will return all table cells.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir only
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def cell_elements(identifier={})
      platform.cells_for(identifier.clone)
    end
    
    #
    # Finds an image
    #
    # @param [Hash] identifier how we find an image.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first image.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def image_element(identifier={:index => 0})
      platform.image_for(identifier.clone)
    end
    
    #
    # Finds all images that match the provided identifier
    #
    # @param [Hash] identifier how we find an image.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empth Hash
    #   which will return all images.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def image_elements(identifier={})
      platform.images_for(identifier.clone)
    end
    
    #
    # Finds a form
    #
    # @param [Hash] identifier how we find a form.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first form.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def form_element(identifier={:index => 0})
      platform.form_for(identifier.clone)
    end

    #
    # Finds all forms that match the provided identifier
    #
    # @param [Hash] identifier how we find a form.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash
    #   which will return all forms.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def form_elements(identifier={})
      platform.forms_for(identifier.clone)
    end
    
    #
    # Finds a list item
    #
    # @param [Hash] identifier how we find a list item.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   whcih will return the first list item.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def list_item_element(identifier={:index => 0})
      platform.list_item_for(identifier.clone)
    end

    #
    # Finds all list items that match the identifier
    #
    # @param [Hash] identifier how we find a list item.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash
    #   which will return all list items.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def list_item_elements(identifier={})
      platform.list_items_for(identifier.clone)
    end

    #
    # Finds an unordered list
    #
    # @param [Hash] identifier how we find an unordered list.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first unordered list.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def unordered_list_element(identifier={:index => 0})
      platform.unordered_list_for(identifier.clone)
    end

    #
    # Finds all unordered lists that match the identifier
    #
    # @param [Hash] identifier how we find an unordered list.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash
    #   which will return all unordered lists.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def unordered_list_elements(identifier={})
      platform.unordered_lists_for(identifier.clone)
    end

    #
    #  Finds an ordered list
    #
    # @param [Hash] identifier how we find an ordered list.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   whcih will return the first ordered list.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def ordered_list_element(identifier={:index => 0})
      platform.ordered_list_for(identifier.clone)
    end
    
    #
    #  Finds all ordered lists that match the identifier
    #
    # @param [Hash] identifier how we find an ordered list.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash
    #   which returns all ordered lists.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def ordered_list_elements(identifier={})
      platform.ordered_lists_for(identifier.clone)
    end
    
    #
    # Finds a h1
    #
    # @param [Hash] identifier how we find a H1.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first h1.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def h1_element(identifier={:index => 0})
      platform.h1_for(identifier.clone)
    end

    #
    # Finds all h1 elements matching the identifier
    #
    # @param [Hash] identifier how we find a H1.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash
    #   which will return all h1s.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def h1_elements(identifier={})
      platform.h1s_for(identifier.clone)
    end

    #
    # Finds a h2
    #
    # @param [Hash] identifier how we find a H2.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first h2.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def h2_element(identifier={:index => 0})
      platform.h2_for(identifier.clone)
    end

    #
    # Finds all h2 elements matching the identifier
    #
    # @param [Hash] identifier how we find a H2.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash
    #   which will return all h2s.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def h2_elements(identifier={})
      platform.h2s_for(identifier.clone)
    end

    #
    # Finds a h3
    #
    # @param [Hash] identifier how we find a H3.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first h3.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def h3_element(identifier={:index => 0})
      platform.h3_for(identifier.clone)
    end

    #
    # Finds all h3 elements for the identifier
    #
    # @param [Hash] identifier how we find a H3.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash
    #   which will return all h3s.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def h3_elements(identifier={})
      platform.h3s_for(identifier.clone)
    end

    #
    # Finds a h4
    #
    # @param [Hash] identifier how we find a H4.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will select the first h4.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def h4_element(identifier={:index => 0})
      platform.h4_for(identifier.clone)
    end

    #
    # Finds all h4 elements matching the identifier
    #
    # @param [Hash] identifier how we find a H4.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash
    #   which will select all h4s.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def h4_elements(identifier={})
      platform.h4s_for(identifier.clone)
    end

    #
    # Finds a h5
    #
    # @param [Hash] identifier how we find a H5.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first h5 element.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def h5_element(identifier={:index => 0})
      platform.h5_for(identifier.clone)
    end

    #
    # Finds all h5 elements for the identifier
    #
    # @param [Hash] identifier how we find a H5.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to using an empty Hash
    #   which will return all h5 elements.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def h5_elements(identifier={})
      platform.h5s_for(identifier.clone)
    end

    #
    # Finds a h6
    #
    # @param [Hash] identifier how we find a H6.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first h6 element.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def h6_element(identifier={:index => 0})
      platform.h6_for(identifier.clone)
    end

    #
    # Finds all h6 elements matching the identifier
    #
    # @param [Hash] identifier how we find a H6.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash
    #   which will return all h6 elements.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def h6_elements(identifier={})
      platform.h6s_for(identifier.clone)
    end

    #
    # Finds a paragraph
    #
    # @param [Hash] identifier how we find a paragraph.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first paragraph.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def paragraph_element(identifier={:index => 0})
      platform.paragraph_for(identifier.clone)
    end

    #
    # Finds all paragraph elements
    #
    # @param [Hash] identifier how we find a paragraph.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty Hash
    #   which will return all paragraphs.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def paragraph_elements(identifier={})
      platform.paragraphs_for(identifier.clone)
    end

    #
    # Finds a label
    #
    # @param [Hash] identifier how we find a label.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   whcih will return the first label.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def label_element(identifier={:index => 0})
      platform.label_for(identifier.clone)
    end

    #
    # Finds all labels that match the provided identifier
    #
    # @param [Hash] identifier how we find a label.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to an empty hash
    #   which returns all labels.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def label_elements(identifier={})
      platform.labels_for(identifier.clone)
    end

    #
    # Finds a file field
    #
    # @param [Hash] identifier how we find a file field.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first file field.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :title => Watir and Selenium
    #   * :xpath => Watir and Selenium
    def file_field_element(identifier={:index => 0})
      platform.file_field_for(identifier.clone)
    end

    #
    # Finds all file fields that match the provided identifier
    #
    # @param [Hash] identifier how we find a file field.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to and empty Hash
    #   which will return all file fields.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :title => Watir and Selenium
    #   * :xpath => Watir and Selenium
    def file_field_elements(identifier={})
      platform.file_fields_for(identifier.clone)
    end

    #
    # Finds an area
    #
    # @param [Hash] identifier how we find an area.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first file field.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    def area_element(identifier={:index => 0})
      platform.area_for(identifier.clone)
    end

    #
    # Finds all areas that match the provided identifier
    #
    # @param [Hash] identifier how we find an area.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to and empty Hash
    #   which will return all file fields.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    def area_elements(identifier={})
      platform.areas_for(identifier.clone)
    end

    #
    # Finds a canvas
    #
    # @param [Hash] identifier how we find a canvas.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first file field.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    def canvas_element(identifier={:index => 0})
      platform.canvas_for(identifier.clone)
    end

    #
    # Finds all canvases that match the provided identifier
    #
    # @param [Hash] identifier how we find a canvas.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to and empty Hash
    #   which will return all file fields.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    def canvas_elements(identifier={})
      platform.canvases_for(identifier.clone)
    end

    #
    # Finds an audio element
    #
    # @param [Hash] identifier how we find an audio.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first file field.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    def audio_element(identifier={:index => 0})
      platform.audio_for(identifier.clone)
    end

    #
    # Finds all audio elements that match the provided identifier
    #
    # @param [Hash] identifier how we find an audio element.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to and empty Hash
    #   which will return all file fields.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    def audio_elements(identifier={})
      platform.audios_for(identifier.clone)
    end

    #
    # Finds a video element
    #
    # @param [Hash] identifier how we find a video.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to {:index => 0}
    #   which will return the first file field.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    def video_element(identifier={:index => 0})
      platform.video_for(identifier.clone)
    end

    #
    # Finds all video elements that match the provided identifier
    #
    # @param [Hash] identifier how we find a video element.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  It defaults to and empty Hash
    #   which will return all file fields.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    def video_elements(identifier={})
      platform.videos_for(identifier.clone)
    end

    #
    # Finds an element
    #
    # @param [Symbol] the name of the tag for the element
    # @param [Hash] identifier how we find an element.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def element(tag, identifier={:index => 0})
      platform.element_for(tag, identifier.clone)
    end
  end
end
