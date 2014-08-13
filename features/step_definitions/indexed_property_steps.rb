class IndexedPropertyPage
  include PageObject

  indexed_property :table, [[:text_field, :text_table, {:id => 'table[%s].text'}],
                            [:text_field, :text_name, {:name => 'tableName[%s].text'}],
                            [:radio_button, :radio, {:id => 'table[%s].radio'}],
                            [:checkbox, :check, {:id => 'table[%s].check'}],
                            [:text_area, :area, {:id => 'table[%s].area'}],
                            [:button, :button, {:id => 'table[%s].button'}],
                            [:div, :content, {:id => 'table[%s].content'}]]

  indexed_property :nottable, [[:text_field, :text_nottable, {:id => 'nottable[%s].text'}]]

  indexed_property :other_table, [
      [:text_field, :text_table, {:id => 'other_table[%s].text'}],
      [:div, :content, {:id => 'other_table[%s].content'}]
  ]

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


When(/^I search for an element not on my indexed property but on another$/) do
  @index = 'foo'
end

Then(/^I should see that the element doesn't exist$/) do
  expect { page.other_table[@index].radio_element.value }.to raise_error(NoMethodError)
end

When(/^I search for an element that is on an indexed property$/) do
  page.table['foo'].radio_element
end

And(/^I search for the element on another indexed property it is not on$/) do
  @index = 'foo'
end

When(/^I search using the index which is not on another indexed property$/) do
  @index = '123'
end

Then(/^I should see that the element doesn't exist for that index/) do
  expect { page.other_table[@index].text_table_element.text }.to raise_error /unable to locate element|Selenium::WebDriver::Error::NoSuchElementError/
end

When(/^I search for an element by an index on an indexed property$/) do
  page.table['123'].text_table_element.html
end

And(/^I search using an index which is on another indexed property$/) do
  @index = 'bar'
end

Then(/^I should see the content of the element on the second indexed property$/) do
  expect(page.other_table['bar'].content).to eq 'bar!'
end

When(/^I search for an element with text by an index on an indexed property$/) do
  expect(page.table['123'].content).to eq '123!'
end