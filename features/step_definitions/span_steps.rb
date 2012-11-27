When /^I get the text from the span$/ do
  @text = @page.span_id
end

When /^I search for the span by "([^\"]*)"$/ do |how|
  @text = @page.send "span_#{how}".to_sym
end

When /^I search for the span by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @text = @page.send "span_#{param1}_#{param2}".to_sym
end

When /^I get the text from a span while the script is executing$/ do
  @text = @page.span_element(:id => 'span_id').text
end

Then /^I should see that the span exists$/ do
  @page.span_id?.should == true
end
