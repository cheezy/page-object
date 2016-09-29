When /^I get the image element$/ do
  @element = @page.image_id_element
end

When /^I get the image element load status$/ do
  @status = @page.image_id_loaded?
end

When /^I get the broken image element load status$/ do
  @status = @page.image_broken_loaded?
end

Then /^the image should be "([^\"]*)" pixels wide$/ do |width|
  @element.width.should == width.to_i
end

Then /^the image should be "([^\"]*)" pixels tall$/ do |height|
  @element.height.should == height.to_i
end

When /^I get the image element by "([^\"]*)"$/ do |how|
  @element = @page.send "image_#{how}_element"
end

When /^I get the image element by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @element = @page.send "image_#{param1}_#{param2}_element"
end

When /^I get the image element while the script is executing$/ do
  @element = @page.image_element(:id => 'image_id')
end

Then /^I should see that the image exists$/ do
  @page.image_id?.should == true
end

Then /^I should see that the image loaded$/ do
  @status.should be true
end

Then /^I should see that the image is not loaded$/ do
  @status.should be false
end
