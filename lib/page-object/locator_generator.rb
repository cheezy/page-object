module PageObject
  module LocatorGenerator

    BASIC_ELEMENTS = [:abbr,
                      :address,
                      :article,
                      :aside,
                      :bdi,
                      :bdo,
                      :cite,
                      :code,
                      :dd,
                      :dfn,
                      :dt,
                      :em,
                      :figcaption,
                      :figure,
                      :footer,
                      :header,
                      :hgroup,
                      :kbd,
                      :mark,
                      :nav,
                      :noscript,
                      :rp,
                      :rt,
                      :ruby,
                      :samp,
                      :section,
                      :sub,
                      :summary,
                      :sup,
                      :var,
                      :wbr]

    ADVANCED_ELEMENTS = [:text_field,
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
                         :video,
                         :svg]

    def self.generate_locators(target)
        ADVANCED_ELEMENTS.each do |tag|
        target.send(:define_method, "#{tag.to_s}_element") do |*identifier|
          @platform.send "#{tag.to_s}_for", locator(identifier)
        end

        target.send(:define_method, "#{tag.to_s}_elements") do |*identifier|
          @platform.send("#{tag.to_s}s_for", identifier[0] ? identifier[0] : {})
        end
      end

      BASIC_ELEMENTS.each do |tag|
        target.send(:define_method, "#{tag.to_s}_element") do |*identifier|
          @platform.send :element_for, tag, locator(identifier)
        end

        target.send(:define_method, "#{tag.to_s}_elements") do |*identifier|
          @platform.send(:elements_for, tag, identifier[0] ? identifier[0] : {})
        end
      end

=begin
      [:as,
       :b,
       :blockquote,
       :body,
       :br,
       :caption,
       :col,
       :colgroup,
       :command,
       :data,
       :datalist,
       :del,
       :details,
       :dialog,
       :dl,
       :embed,
       :fieldset,
       :head,
       :hr,
       :i,
       :ins,
       :keygen,
       :legend,
       :map,
       :menu,
       :meta,
       :meter,
       :object,
       :optgroup,
       :output,
       :param,
       :pre,
       :progress,
       :q,
       :s,
       :small,
       :strong,
       :style,
       :time,
       :title,
       :track,
       :u].each do |tag|
        target.send(:define_method, "#{tag.to_s}_element") do |*identifier|
          @platform.send :element_for, tag, locator(identifier)
        end

        target.send(:define_method, "#{tag.to_s}_elements") do |*identifier|
          @platform.send(:elements_for, tag, identifier[0] ? identifier[0] : {})
        end
      end
=end
    end

  end
end
