When /^I type "([^\"]*)" into the text field$/ do |text|
  @page.text_field_id = text
end

Then /^the text field should contain "([^\"]*)"$/ do |expected_text|
  @page.text_field_id.should == expected_text
end

When /^I search for the text field by "([^\"]*)"$/ do |how|
  @how = how
end

Then /^I should be able to type "([^\"]*)" into the field$/ do |value|
  @page.send "text_field_#{@how}=".to_sym, value
end

When /^I select the link labeled "([^\"]*)"$/ do |text|
  @page.google_search_id
end

When /^I search for the link by "([^\"]*)"$/ do |how|
  @how = how
end

Then /^I should be able to select the link$/ do
  @page.send "google_search_#{@how}".to_sym
end


