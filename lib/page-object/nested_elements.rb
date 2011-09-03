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
  end
end
