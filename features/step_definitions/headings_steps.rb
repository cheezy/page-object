When /^I get the text for the "([^\"]*)" element$/ do |el|
  @heading = @page.send "#{el}_id"
end

Then /^I should see "([^\"]*)"$/ do |text|
  @heading.should == text
end
