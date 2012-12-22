Given /^I am on the Gxt Examples page$/ do
  @page = GxtSamplePageObject.new(@browser)
  @page.navigate_to "http://gxtexamplegallery.appspot.com/"
end

When /^I have the Basic Grid opened$/ do
  @page.basic_grid_element.click
end

When /^I have defined a GxtTable class extending Table$/ do
  class GxtTable < PageObject::Elements::Table

    protected
    def child_xpath
      ".//descendant::tr"
    end
  end
end

When /^I have registered the GxtTable with PageObject$/ do
  PageObject.register_widget :gxt_table, GxtTable, 'div'
end

When /^I retrieve a GxtTable widget$/ do
  @element = @page.gxt_table_element
end


When /^the GxtTable should have "(\d+)" rows$/ do |rows|
  @element.rows.should == rows.to_i
end

When /^I define a page-object using that widget$/ do
  class GxtSamplePageObject
    include PageObject

    div(:basic_grid, :class => "label_basic_grid")
    gxt_table(:gxt_table, :class => "x-grid3")
  end
end
