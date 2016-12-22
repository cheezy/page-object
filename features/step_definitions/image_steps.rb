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
  expect(@element.width).to eql width.to_i
end

Then /^the image should be "([^\"]*)" pixels tall$/ do |height|
  expect(@element.height).to eql height.to_i
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
  expect(@page.image_id?).to be true
end

Then /^I should see that the image loaded$/ do
  expect(@status).to be true
end

Then /^I should see that the image is not loaded$/ do
  expect(@status).to be false
end
