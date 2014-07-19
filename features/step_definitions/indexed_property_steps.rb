class IndexedPropertyPage
  include PageObject

  indexed_property :table, [[:text_field, :text_table, {:id => 'table[%s].text'}],
                            [:text_field, :text_name, {:name => 'tableName[%s].text'}],
                            [:radio_button, :radio, {:id => 'table[%s].radio'}],
                            [:checkbox, :check, {:id => 'table[%s].check'}],
                            [:text_area, :area, {:id => 'table[%s].area'}],
                            [:button, :button, {:id => 'table[%s].button'}]]

  indexed_property :nottable, [[:text_field, :text_nottable, {:id => 'nottable[%s].text'}]]

end

def page
  @page ||= IndexedPropertyPage.new(@browser)
end

Given /^I am on the indexed property page$/ do
#  @page = IndexedPropertyPage.new(@browser)
  page.navigate_to(UrlHelper.indexed)
end

When /^I search for the elements for index "([^\"]*)"$/ do |index|
  @index = index
end

Then /^I type "([^\"]*)" into the table's indexed text field by id$/ do |val|
  page.table[@index].text_table = val
end

Then /^The table's indexed text field by id should contain "([^\"]*)"$/ do |val|
  page.table[@index].text_table.should == val
end

Then /^I type "([^\"]*)" into the table's indexed text field by name$/ do |val|
  page.table[@index].text_name = val
end

Then /^The table's indexed text field by name should contain "([^\"]*)"$/ do |val|
  page.table[@index].text_name.should == val
end

Then /^I select the indexed radio button$/ do
  page.table[@index].select_radio
end

Then /^The indexed radio button should be selected$/ do
  page.table[@index].radio_selected?.should == true
end

Then /^I check the indexed checkbox$/ do
  page.table[@index].check_check
end

Then /^The indexed checkbox should be checked$/ do
  page.table[@index].check_checked?.should == true
end

Then /^I type "([^\"]*)" into the table's indexed text area$/ do |val|
  page.table[@index].area = val
end

Then /^The table's indexed text area should contain "([^\"]*)"$/ do |val|
  page.table[@index].area.should == val
end

Then /^I should see that the indexed button exists$/ do
  page.table[@index].button?.should == true
end

Then /^I should be able to click the indexed button$/ do
  page.table[@index].button
end

Then /^I type "([^\"]*)" into the regular indexed text field by id$/ do |val|
  page.nottable[@index].text_nottable = val
end

Then /^The regular indexed text field by id should contain "([^\"]*)"$/ do |val|
  page.nottable[@index].text_nottable.should == val
end

