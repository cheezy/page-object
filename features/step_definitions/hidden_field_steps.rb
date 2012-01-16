When /^I retrieve the hidden field element$/ do
  @element = @page.hidden_field_id_element
end

Then /^I should see the hidden field contains "([^\"]*)"$/ do |text|
  @page.hidden_field_id.should == text
end

When /^I search for the hidden field by "([^\"]*)"$/ do |how|
  @element = @page.send "hidden_field_#{how}_element"
end

Then /^the hidden field element should contain "([^\"]*)"$/ do |text|
  @element.value.should == text
end

When /^I search for the hidden field by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @element = @page.send "hidden_field_#{param1}_#{param2}_element"
end

When /^I find a hidden field while the script is executing$/ do
  @element = @page.hidden_field_element(:id => 'hidden_field_id')
end

Then /^I should see that the hidden field exists$/ do
  @page.hidden_field_id?.should == true
end