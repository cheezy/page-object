module PageObject
  module LocatorGenerator

    def self.generate_locators(target)
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
        target.send(:define_method, "#{tag.to_s}_element") do |*identifier|
          @platform.send "#{tag.to_s}_for", locator(identifier)
        end

        target.send(:define_method, "#{tag.to_s}_elements") do |*identifier|
          @platform.send "#{tag.to_s}s_for", identifier[0] ? identifier[0] : {}
        end
      end
    end

  end
end
