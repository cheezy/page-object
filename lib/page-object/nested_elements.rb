module PageObject
  module NestedElements

    def locator(identifier)
      return identifier.first unless identifier.empty?
      {:index => 0}
    end

    [:text_field,
     :hidden_field,
     :text_area,
     :select_list,
     :link,
     :checkbox,
     :radio_button,
     :button,
     :div,
     :span,
     :table,
     :cell,
     :image,
     :form,
     :list_item,
     :ordered_list,
     :unordered_list,
     :h1,
     :h2,
     :h3,
     :h4,
     :h5,
     :h6,
     :paragraph,
     :label,
     :file_field,
     :area,
     :canvas,
     :audio,
     :video].each do |tag|
      define_method("#{tag.to_s}_element") do |*identifier|
        @platform.send "#{tag.to_s}_for", locator(identifier)
      end

      define_method("#{tag.to_s}_elements") do |*identifier|
        @platform.send "#{tags.to_s}s_for", locator(identifier)
      end
    end

    end
  end
end
