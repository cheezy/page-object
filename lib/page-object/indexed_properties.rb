module PageObject
  module IndexedProperties
    class RowOfElements
      include PageObject
      include LoadsPlatform
      extend Accessors

      def initialize (browser, index, identifier_list)
        initialize_browser(browser)

        identifier_list.each do |identifier|
          type = identifier[0]
          name = identifier[1]
          how_and_what = identifier[2].clone # Cannot modify the original...
          how_and_what.each do |key, value|
            how_and_what[key] = value % index
          end
          self.class.send type, name, how_and_what
        end
      end
    end

    class TableOfElements
      include PageObject
      include LoadsPlatform

      def initialize (browser, identifier_list)
        initialize_browser(browser)
        @identifier_list = identifier_list
      end

      def [] (index)
        RowOfElements.new(@browser, index, @identifier_list)
      end
    end
  end
end