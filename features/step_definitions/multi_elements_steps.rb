class MultiElementsPage
  include PageObject
end


Given /^I am on the multi elements page$/ do
  @page = MultiElementsPage.new(@browser)
  @page.navigate_to(UrlHelper.multi)
end

When /^I select the buttons with class "([^\"]*)"$/ do |class_name|
  @elements = @page.button_elements(:class => class_name)
end

Then /^I should have (\d+) buttons$/ do |num_buttons|
  @elements.size.should == num_buttons.to_i
end

Then /^the value of button (\d+) should be "([^\"]*)"$/ do |button_num, value|
  @elements[button_num.to_i - 1].value.should == value
end

When /^I select the text fields with class "([^\"]*)"$/ do |class_name|
  @elements = @page.text_field_elements(:class => class_name)
end

Then /^I should have (\d+) text fields$/ do |num_text_fields|
  @elements.size.should == num_text_fields.to_i
end

Then /^the value of text field (\d+) should be "([^\"]*)"$/ do |text_field_num, value|
  @elements[text_field_num.to_i - 1].value.should == value
end

When /^I select the hidden fields with class "([^\"]*)"$/ do |class_name|
  @elements = @page.hidden_field_elements(:class => class_name)
end

Then /^I should have (\d+) hidden fields$/ do |num_hidden_fields|
  @elements.size.should == num_hidden_fields.to_i
end

Then /^the value of hidden field (\d+) should be "([^\"]*)"$/ do |hidden_field_num, value|
  @elements[hidden_field_num.to_i - 1].value.should == value
end
