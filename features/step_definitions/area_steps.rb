When /^I search for the area by "([^\"]*)"$/ do |how|
  @how = how
end

Then /^I should be able to click the area$/ do
  @page.send("area_#{@how}")
end

Then /^I should see the coordinates are "([^\"]*)"$/ do |coords|
  @element.coords.should == coords
end

Then /^I should see the shape is "([^\"]*)"$/ do |shape|
  @element.shape.should == shape
end

Then /^I should see the href is "([^\"]*)"$/ do |href|
  @element.href.should include href
end
