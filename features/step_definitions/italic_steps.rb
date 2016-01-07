When /^I get the italic text for the "([^\"]*)" element$/ do |el|
  @i = @page.send "#{el}_id"
end

Then /^I should see "([^\"]*)" in italic$/ do |text|
  @i.should == text
end

When /^I search italic text for the (\w+) by "([^"]*)"$/ do |text_decorator, type|
  @i = @page.send "#{text_decorator}_#{type}"
end

