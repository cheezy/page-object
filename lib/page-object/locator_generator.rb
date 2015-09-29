module PageObject
  module LocatorGenerator

    BASIC_ELEMENTS = [:abbr,
                      :address,
                      :article,
                      :as,
                      :aside,
                      :bdi,
                      :bdo,
                      :blockquote,
                      :body,
                      :br,
                      :caption,
                      :cite,
                      :code,
                      :col,
                      :colgroup,
                      :command,
                      :data,
                      :datalist,
                      :dd,
                      :del,
                      :details,
                      :dfn,
                      :dialog,
                      :dl,
                      :dt,
                      :em,
                      :embed,
                      :fieldset,
                      :figcaption,
                      :figure,
                      :footer,
                      :head,
                      :header,
                      :hgroup,
                      :hr,
                      :ins,
                      :kbd,
                      :keygen,
                      :legend,
                      :map,
                      :mark,
                      :menu,
                      :meta,
                      :meter,
                      :nav,
                      :noscript,
                      :object,
                      :optgroup,
                      :output,
                      :param,
                      :pre,
                      :progress,
                      :rp,
                      :rt,
                      :ruby,
                      :samp,
                      :section,
                      :small,
                      :strong,
                      :style,
                      :sub,
                      :summary,
                      :sup,
                      :time,
                      :title,
                      :track,
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
                         :row,
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
                         :b,
                         :i,
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
    end

  end
end
