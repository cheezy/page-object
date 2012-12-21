When /^I get the first item from the ordered list$/ do
  @element = @page.ol_id_element[0]
end

When /^I search for the ordered list by "([^\"]*)"$/ do |how|
  @list = @page.send "ol_#{how}_element"
end

When /^I search for the ordered list by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @list = @page.send "ol_#{param1}_#{param2}_element"
end

When /^I search for the ordered list while the script is executing$/ do
  @list = @page.ordered_list_element(:id => 'ol_id')
end

Then /^I should see that the ordered list exists$/ do
  @page.ol_id?.should == true
end

Then /^the text for the ordered list should contain "(.*)"$/ do |text|
  @page.send("ol_id").should include text
end
