module PageObject
  module NestedElements

    def link_element(identifier={:index => 0})
      @platform.link_for(identifier)
    end

    def link_elements(identifier={:index => 0})
      @platform.links_for(identifier)
    end

    def button_element(identifier={:index => 0})
      @platform.button_for(identifier)
    end

    def button_elements(identifier={:index => 0})
      @platform.buttons_for(identifier)
    end

    def text_field_element(identifier={:index => 0})
      @platform.text_field_for(identifier)
    end

    def text_field_elements(identifier={:index => 0})
      @platform.text_fields_for(identifier)
    end

    def hidden_field_element(identifier={:index => 0})
      @platform.hidden_field_for(identifier)
    end

    def hidden_field_elements(identifier={:index => 0})
      @platform.hidden_fields_for(identifier)
    end

    def text_area_element(identifier={:index => 0})
      @platform.text_area_for(identifier)
    end

    def text_area_elements(identifier={:index => 0})
      @platform.text_areas_for(identifier)
    end

    def select_list_element(identifier={:index => 0})
      @platform.select_list_for(identifier)
    end

    def select_list_elements(identifier={:index => 0})
      @platform.select_lists_for(identifier)
    end

    def checkbox_element(identifier={:index => 0})
      @platform.checkbox_for(identifier)
    end

    def checkbox_elements(identifier={:index => 0})
      @platform.checkboxes_for(identifier)
    end

    def radio_button_element(identifier={:index => 0})
      @platform.radio_button_for(identifier)
    end

    def radio_button_elements(identifier={:index => 0})
      @platform.radio_buttons_for(identifier)
    end

    def div_element(identifier={:index => 0})
      @platform.div_for(identifier)
    end

    def div_elements(identifier={:index => 0})
      @platform.divs_for(identifier)
    end

    def span_element(identifier={:index => 0})
      @platform.span_for(identifier)
    end

    def span_elements(identifier={:index => 0})
      @platform.spans_for(identifier)
    end

    def table_element(identifier={:index => 0})
      @platform.table_for(identifier)
    end
    
    def table_elements(identifier={:index => 0})
      @platform.tables_for(identifier)
    end
    
    def cell_element(identifier={:index => 0})
      @platform.cell_for(identifier)
    end
    
    def cell_elements(identifier={:index => 0})
      @platform.cells_for(identifier)
    end
    
    def image_element(identifier={:index => 0})
      @platform.image_for(identifier)
    end
    
    def image_elements(identifier={:index => 0})
      @platform.images_for(identifier)
    end
    
    def form_element(identifier={:index => 0})
      @platform.form_for(identifier)
    end
    
    def form_elements(identifier={:index => 0})
      @platform.forms_for(identifier)
    end
    
    def ordered_list_element(identifier={:index => 0})
      @platform.ordered_list_for(identifier)
    end
    
    def ordered_list_elements(identifier={:index => 0})
      @platform.ordered_lists_for(identifier)
    end
    
    def unordered_list_element(identifier={:index => 0})
      @platform.unordered_list_for(identifier)
    end
    
    def unordered_list_elements(identifier={:index => 0})
      @platform.unordered_lists_for(identifier)
    end
    
    def list_item_element(identifier={:index => 0})
      @platform.list_item_for(identifier)
    end
    
    def list_item_elements(identifier={:index => 0})
      @platform.list_items_for(identifier)
    end
    
    def h1_element(identifier={:index => 0})
      @platform.h1_for(identifier)
    end
    
    def h1_elements(identifier={:index => 0})
      @platform.h1s_for(identifier)
    end
    
    def h2_element(identifier={:index => 0})
      @platform.h2_for(identifier)
    end
    
    def h2_elements(identifier={:index => 0})
      @platform.h2s_for(identifier)
    end

    def h3_element(identifier={:index => 0})
      @platform.h3_for(identifier)
    end
    
    def h3_elements(identifier={:index => 0})
      @platform.h3s_for(identifier)
    end
    
    def h4_element(identifier={:index => 0})
      @platform.h4_for(identifier)
    end

    def h4_elements(identifier={:index => 0})
      @platform.h4s_for(identifier)
    end

    def h5_element(identifier={:index => 0})
      @platform.h5_for(identifier)
    end
    
    def h5_elements(identifier={:index => 0})
      @platform.h5s_for(identifier)
    end

    def h6_element(identifier={:index => 0})
      @platform.h6_for(identifier)
    end
    
    def h6_elements(identifier={:index => 0})
      @platform.h6s_for(identifier)
    end

    def paragraph_element(identifier={:index => 0})
      @platform.paragraph_for(identifier)
    end

    def paragraph_elements(identifier={:index => 0})
      @platform.paragraphs_for(identifier)
    end

    def label_element(identifier={:index => 0})
      @platform.label_for(identifier)
    end

    def label_elements(identifier={:index => 0})
      @platform.labels_for(identifier)
    end

    def file_field_element(identifier={:index => 0})
      @platform.file_field_for(identifier)
    end

    def area_element(identifier={:index => 0})
      @platform.area_for(identifier)
    end

    def area_elements(identifier={:index => 0})
      @platform.areas_for(identifier)
    end

    def canvas_element(identifier={:index => 0})
      @platform.canvas_for(identifier)
    end

    def canvas_elements(identifier={:index => 0})
      @platform.canvases_for(identifier)
    end

    def audio_element(identifier={:index => 0})
      @platform.audio_for(identifier)
    end

    def audio_elements(identifier={:index => 0})
      @platform.audios_for(identifier)
    end
    
    def video_element(identifier={:index => 0})
      @platform.video_for(identifier)
    end

    def video_elements(identifier={:index => 0})
      @platform.video_for(identifier)
    end
  end
end
