When /^I search for the table row by "([^\"]*)"$/ do |how|
  @row_data = @page.send "tr_#{how}"
end

When /^I retrieve a table row element by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @row_data = @page.send "tr_#{param1}_#{param2}"
end

When /^I retrieve a table row element while the script is executing$/ do
  @row_data = @page.tr_element(:id => 'tr_id').text
end

Then /^I should see that the row exists$/ do
  @page.tr_id?.should == true
end

When /^I retrieve the data from the table row/ do
  @row_data = @page.tr_id
end

Then /^the row data should be '([^"]*)'$/ do |expected|
  @row_data.should == expected
end