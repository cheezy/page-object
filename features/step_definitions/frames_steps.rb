class FramePage
  include PageObject
end

Given /^I am on the frame elements page$/ do
  @page = FramePage.new(@browser)
  @page.navigate_to(UrlHelper.frame_elements)
end

When /^I switch to a frame using id "([^"]*)"$/ do |id|
  @page.switch_to_frame(id)
end

Then /^I should see "([^"]*)" in the frame$/ do |text|
  @page.text.should include text
end

When /^I switch to a frame using index "([^"]*)"$/ do |index|
  @page.switch_to_frame(index.to_i)
end

