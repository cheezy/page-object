class NestedElementsPage
  include PageObject
  
  div(:outer_div, :id => 'div_id')
  link(:nested_link) { |page| page.outer_div_element.link_element }
  button(:nested_button) { |page| page.outer_div_element.button_element }
  text_field(:nested_text_field) { |page| page.outer_div_element.text_field_element }
  hidden_field(:nested_hidden_field) { |page| page.outer_div_element.hidden_field_element }
  text_area(:nested_text_area) { |page| page.outer_div_element.text_area_element }
  select_list(:nested_select_list) { |page| page.outer_div_element.select_list_element }
  
end

Given /^I am on the nested elements page$/ do
  @page = NestedElementsPage.new(@browser)
  @page.navigate_to(UrlHelper.nested_elements)
end

When /^I search for a link located in a div$/ do
  @link = @page.nested_link_element
end

Then /^I should be able to click the nested link$/ do
  @link.click
end

When /^I search for a button located in a div$/ do
  @button = @page.nested_button_element
end

Then /^I should be able to click the nested button$/ do
  @button.click
end

When /^I search for a text field located in a div$/ do
  @text_field = @page.nested_text_field_element
end

Then /^I should be able to type "([^\"]*)" in the nested text field$/ do |value|
  @text_field.value = value
end

When /^I search for a hidden field located in a div$/ do
  @hidden_field = @page.nested_hidden_field_element
end

Then /^I should be able to see that the nested hidden field contains "([^\"]*)"$/ do |value|
  @hidden_field.value.should == value
end

When /^I search for a text area located in a div$/ do
  @text_area = @page.nested_text_area_element
end

Then /^I should be able to type "([^\"]*)" in the nested text area$/ do |value|
  @text_area.value = value
end

When /^I search for a select list located in a div$/ do
  @select_list = @page.nested_select_list_element
end

Then /^I shoudl be able to select "([^\"]*)"$/ do |value|
  @select_list.select value
end
