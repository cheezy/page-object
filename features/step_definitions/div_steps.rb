When /^I get the text from the div$/ do
  @text = @page.div_id
end

When /^I search for the div by "([^\"]*)"$/ do |how|
  @text = @page.send "div_#{how}".to_sym
end

When /^I search for the div by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @text = @page.send "div_#{param1}_#{param2}".to_sym
end

When /^I get the text from a div while the script is executing$/ do
  @text = @page.div_element(:id => 'div_id').text
end

Then /^I should see that the div exists$/ do
  @page.div_id?.should == true
end
