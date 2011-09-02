class NestedElementsPage
  include PageObject
  
  div(:outer_div, :id => 'div_id')
  link(:nested_link) { |page| page.outer_div_element.link_element(:text => 'Success') }
  button(:nested_button) { |page| page.outer_div_element.button_element(:value => 'Click Me') }
  
end

Given /^I am on the nested elements page$/ do
  @page = NestedElementsPage.new(@browser)
  @page.navigate_to(UrlHelper.nested_elements)
end

When /^I search for a link located in a div with id "([^\"]*)"$/ do |div_id|
  @link = @page.nested_link_element
end

Then /^I should be able to click the nested link$/ do
  @link.click
end

When /^I search for a button located in a div with id "([^\"]*)"$/ do |arg1|
  @button = @page.nested_button_element
end

Then /^I should be able to click the nested button$/ do
  @button.click
end

