When /^I search for the table cell by "([^\"]*)"$/ do |how|
  @cell_data = @page.send "cell_#{how}"
end

When /^I retrieve a table cell element by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @cell_data = @page.send "cell_#{param1}_#{param2}"
end

When /^I retrieve a table cell element while the script is executing$/ do
  @cell_data = @page.cell_element(:id => 'cell_id').text
end

Then /^I should see that the cell exists$/ do
  @page.cell_id?.should == true
end