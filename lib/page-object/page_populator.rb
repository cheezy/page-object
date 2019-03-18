module PageObject
  module PagePopulator

    #
    # This method will populate all matched page TextFields,
    # TextAreas, SelectLists, FileFields, Checkboxes, and Radio Buttons from the
    # Hash passed as an argument.  The way it find an element is by
    # matching the Hash key to the name you provided when declaring
    # the element on your page.
    #
    # Checkbox and Radio Button values must be true or false.
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
    # @param data [Hash] the data to use to populate this page.  The key
    # can be either a string or a symbol.  The value must be a string
    # for TextField, TextArea, SelectList, and FileField and must be true or
    # false for a Checkbox or RadioButton.
    #
    def populate_page_with(data)
      data.to_h.each do |key, value|
        populate_section(key, value) if value.respond_to?(:to_h)
        populate_value(self, key, value)
      end
    end

    private

    def populate_section(section, data)
      return unless self.respond_to? section
      data.to_h.each do |key, value|
        populate_value(self.send(section), key, value)
      end
    end

    def populate_value(receiver, key, value)
      populate_checkbox(receiver, key, value) if is_checkbox?(receiver, key) and is_enabled?(receiver, key)
      populate_radiobuttongroup(receiver, key, value) if is_radiobuttongroup?(receiver, key)
      populate_radiobutton(receiver, key, value) if is_radiobutton?(receiver, key) and is_enabled?(receiver, key)
      populate_select_list(receiver, key, value) if is_select_list?(receiver, key)
      populate_text(receiver, key, value) if is_text?(receiver, key) and is_enabled?(receiver, key)
    end
    
    def populate_text(receiver, key, value)
      receiver.send "#{key}=", value
    end

    def populate_checkbox(receiver, key, value)
      return receiver.send "check_#{key}" if value
      receiver.send "uncheck_#{key}"
    end

    def populate_radiobutton(receiver, key, value)
      receiver.send "select_#{key}" if value
    end

    def populate_radiobuttongroup(receiver, key, value)
      receiver.send("select_#{key}", value)
    end

    def populate_select_list(receiver, key, value)
      receiver.send "#{key}=", value
    end

    def is_text?(receiver, key)
      return false if is_select_list?(receiver, key)
      receiver.respond_to?("#{key}=".to_sym)
    end

    def is_checkbox?(receiver, key)
      receiver.respond_to?("check_#{key}".to_sym)
    end

    def is_radiobutton?(receiver, key)
      receiver.respond_to?("select_#{key}".to_sym)
    end

    def is_radiobuttongroup?(receiver, key)
      receiver.respond_to?("select_#{key}".to_sym) and receiver.respond_to?("#{key}_values")
    end

    def is_select_list?(receiver, key)
      receiver.respond_to?("#{key}_options".to_sym)
    end

    def is_enabled?(receiver, key)
      return false if is_radiobuttongroup?(receiver, key)
      return true if (receiver.send "#{key}_element").tag_name == "textarea"
      element = receiver.send("#{key}_element")
      element.enabled? and element.present?
    end
  end
end
