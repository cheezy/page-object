module PageObject
  module NestedElements

    def link_element(identifier={:index => 0})
      @platform.link_for(identifier)
    end

    def button_element(identifier={:index => 0})
      @platform.button_for(identifier)
    end

    def text_field_element(identifier={:index => 0})
      @platform.text_field_for(identifier)
    end

    def hidden_field_element(identifier={:index => 0})
      @platform.hidden_field_for(identifier)
    end

    def text_area_element(identifier={:index => 0})
      @platform.text_area_for(identifier)
    end

    def select_list_element(identifier={:index => 0})
      @platform.select_list_for(identifier)
    end

    def checkbox_element(identifier={:index => 0})
      @platform.checkbox_for(identifier)
    end

    def radio_button_element(identifier={:index => 0})
      @platform.radio_button_for(identifier)
    end

    def div_element(identifier={:index => 0})
      @platform.div_for(identifier)
    end

    def span_element(identifier={:index => 0})
      @platform.span_for(identifier)
    end

    def table_element(identifier={:index => 0})
      @platform.table_for(identifier)
    end
    
    def cell_element(identifier={:index => 0})
      @platform.cell_for(identifier)
    end
    
    def image_element(identifier={:index => 0})
      @platform.image_for(identifier)
    end
    
    def form_element(identifier={:index => 0})
      @platform.form_for(identifier)
    end
    
    def ordered_list_element(identifier={:index => 0})
      @platform.ordered_list_for(identifier)
    end
    
    def unordered_list_element(identifier={:index => 0})
      @platform.unordered_list_for(identifier)
    end
    
    def list_item_element(identifier={:index => 0})
      @platform.list_item_for(identifier)
    end
    
    def h1_element(identifier={:index => 0})
      @platform.h1_for(identifier)
    end
    
    def h2_element(identifier={:index => 0})
      @platform.h2_for(identifier)
    end

    def h3_element(identifier={:index => 0})
      @platform.h3_for(identifier)
    end
    
    def h4_element(identifier={:index => 0})
      @platform.h4_for(identifier)
    end

    def h5_element(identifier={:index => 0})
      @platform.h5_for(identifier)
    end

    def h6_element(identifier={:index => 0})
      @platform.h6_for(identifier)
    end
  end
end
