module PageObject
  module IndexedProperties
    class TableOfElements
      include PageObject

      def initialize (browser, identifier_list)
        initialize_browser(browser)
        @identifier_list = identifier_list
        @indexed_property_class = Class.new {
          include PageObject
          extend Accessors

          def initialize (browser, index, identifier_list)
            initialize_browser(browser)

            identifier_list.each do |identifier|
              type = identifier[0]
              name = identifier[1]
              how_and_what = identifier[2].clone # Cannot modify the original...
              how_and_what.each do |key, value|
                next if value.is_a? Regexp # Cannot format Regexp with %
                if key == :index
                  how_and_what[key] = (value % index).to_i
                elsif key == :frame
                  how_and_what[key] = value #passthrough frame without modification
                else
                  how_and_what[key] = value % index
                end
              end
              self.class.send type, name, how_and_what unless Class.instance_methods.include? name
            end
          end
        }
      end

      def [] (index)
        @indexed_property_class.new(@browser, index, @identifier_list)
      end
    end
  end
end
