When /^I get the bold text for the "([^\"]*)" element$/ do |el|
  @b = @page.send "#{el}_id"
end

Then /^I should see "([^\"]*)" in bold$/ do |text|
  @b.should == text
end

When /^I search bold text for the (\w+) by "([^"]*)"$/ do |text_decorator, type|
  @b = @page.send "#{text_decorator}_#{type}"
end

