When /^I get the image element$/ do
  @element = @page.image_id_element
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
