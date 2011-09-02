class NestedElementsPage
  include PageObject
  
  div(:outer_div, :id => 'div_id')
  link(:nested_link) { |page| page.outer_div_element.link_element(:index => 0) }
  button(:nested_button) { |page| page.outer_div_element.button_element(:index => 0) }
  text_field(:nested_text_field) { |page| page.outer_div_element.text_field_element(:index => 0) }
  
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

