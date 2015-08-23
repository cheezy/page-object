
def class_exists?(class_name)
  begin
    klass = Module.const_get(class_name)
    return klass.is_a?(Class)
  rescue NameError
    return false
  end
end

Given /^I am on the Gxt Examples page$/ do
  visit GxtSamplePageObject
end

When /^I have defined a GxtTable class extending Table$/ do
  class GxtTable < PageObject::Elements::Table

    def self.accessor_methods(accessor, name)
      accessor.send :define_method, "#{name}_rows" do
        self.send("#{name}_element").rows
      end
    end
    
    protected
      def child_xpath
        ".//descendant::tr"
      end
  end
end

When /^I define a page-object using that widget$/ do
  class GxtSamplePageObject
    include PageObject

    page_url UrlHelper.widgets

    gxt_table(:gxt_table, :class => "x-grid3")
  end unless class_exists? 'GxtSamplePageObject'
end

When /^I have registered the GxtTable with PageObject$/ do
  PageObject.register_widget :gxt_table, GxtTable, 'div'
end

When /^I retrieve a GxtTable widget$/ do
  @element = on(GxtSamplePageObject).gxt_table_element
end


When /^the GxtTable should have "(\d+)" rows$/ do |rows|
  on(GxtSamplePageObject).gxt_table_rows.should == rows.to_i
end

