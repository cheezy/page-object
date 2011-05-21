When /^I retrieve a check box element$/ do
  @element = @page.cb_id_checkbox
end

Then /^I should know it exists$/ do
  @element.should exist
end

Then /^I should know it is visible$/ do
  @element.should be_visible
end

