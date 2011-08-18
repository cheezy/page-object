module PageObject
  module  ElementLocators
    
    def button(identifier)
      platform.button_for(identifier.clone)
    end
    
  end
end