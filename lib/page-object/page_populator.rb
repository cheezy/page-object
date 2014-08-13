module PageObject
  module PagePopulator

    #
    # This method will populate all matched page TextFields,
    # TextAreas, SelectLists, FileFields, Checkboxes, and Radio Buttons from the
    # Hash passed as an argument.  The way it find an element is by
    # matching the Hash key to the name you provided when declaring
    # the element on your page.
    #
    # Checkboxe and Radio Button values must be true or false.
    #
    # @example
    #   class ExamplePage
    #     include PageObject
    #
    #     text_field(:username, :id => 'username_id')
    #     checkbox(:active, :id => 'active_id')
    #   end
    #
    #   ...
    #
    #   @browser = Watir::Browser.new :firefox
    #   example_page = ExamplePage.new(@browser)
    #   example_page.populate_page_with :username => 'a name', :active => true
    #
    # @param [Hash] the data to use to populate this page.  The key
    # can be either a string or a symbol.  The value must be a string
    # for TextField, TextArea, SelectList, and FileField and must be true or
    # false for a Checkbox or RadioButton.
    #
    def populate_page_with(data)
      data.each do |key, value|
        populate_checkbox(key, value) if is_checkbox?(key) and is_enabled?(key)
        populate_radiobuttongroup(key, value) if is_radiobuttongroup?(key)
        populate_radiobutton(key, value) if is_radiobutton?(key) and is_enabled?(key)
        populate_text(key, value) if is_text?(key) and is_enabled?(key)
      end
    end

    private
    
    def populate_text(key, value)
      self.send "#{key}=", value
    end

    def populate_checkbox(key, value)
      return self.send "check_#{key}" if value
      return self.send "uncheck_#{key}"
    end

    def populate_radiobutton(key, value)
      return self.send "select_#{key}" if value
    end

    def populate_radiobuttongroup(key, value)
      return self.send("select_#{key}", value)
    end

    def is_text?(key)
      respond_to?("#{key}=".to_sym)
    end

    def is_checkbox?(key)
      respond_to?("check_#{key}".to_sym)
    end

    def is_radiobutton?(key)
      respond_to?("select_#{key}".to_sym)
    end

    def is_radiobuttongroup?(key)
      respond_to?("select_#{key}".to_sym) and respond_to?("#{key}_values")
    end

    def is_enabled?(key)
      return false if is_radiobuttongroup?(key)
      return true if (self.send "#{key}_element").tag_name == "textarea"
      element = self.send("#{key}_element")
      element.enabled? and element.visible?
    end
  end
end
