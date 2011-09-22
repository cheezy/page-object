When /^I get the text for the "([^\"]*)" element$/ do |el|
  @heading = @page.send "#{el}_id"
end

Then /^I should see "([^\"]*)"$/ do |text|
  @heading.should == text
end

When /^I search for the heading1 by "([^"]*)"$/ do |type|
  @heading = @page.send "h1_#{type}"
end
