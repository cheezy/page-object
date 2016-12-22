When /^I search for the area by "([^\"]*)"$/ do |how|
  @how = how
end

Then /^I should be able to click the area$/ do
  @page.send("area_#{@how}")
end

Then /^I should see the coordinates are "([^\"]*)"$/ do |coords|
  expect(@element.coords).to eql coords
end

Then /^I should see the shape is "([^\"]*)"$/ do |shape|
  expect(@element.shape).to eql shape
end

Then /^I should see the href is "([^\"]*)"$/ do |href|
  expect(@element.href).to include href
end
