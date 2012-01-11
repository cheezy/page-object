
When /^I get the text from the paragraph$/ do
  @text = @page.p_id
end

When /^I search for the paragraph by "([^"]*)"$/ do |how|
  @text = @page.send "p_#{how}".to_sym
end

When /^I search for the paragraph by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @text = @page.send "p_#{param1}_#{param2}"
end

When /^I get the text from a paragraph while the script is executing$/ do
  @text = @page.paragraph_element(:id => 'p_id').text
end

Then /^I should see that the paragraph exists$/ do
  @page.p_id?.should == true
end
