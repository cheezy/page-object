module PageObject
  module PagePopulator

    def populate_page_with(data)
      data.each do |key, value|
        populate_checkbox(key, value) if is_checkbox?(key)
        populate_radiobutton(key, value) if is_radiobutton?(key)
        populate_text(key, value) if is_text?(key)
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
      return self.send "clear_#{key}"
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
  end
end
