When /^I retrieve a check box element$/ do
  @element = @page.cb_id_checkbox
end

When /^I retrieve a link element$/ do
  @element = @page.google_search_id_link
end

When /^I retrieve a radio button$/ do
  @element = @page.milk_id_radio_button
end

Then /^I should know it exists$/ do
  @element.should exist
end

Then /^I should know it is visible$/ do
  @element.should be_visible
end

