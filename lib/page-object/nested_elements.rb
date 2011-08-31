module PageObject
  module NestedElements
    
    def link_element(identifier)
      @platform.link_for(identifier)
    end
    
  end
end