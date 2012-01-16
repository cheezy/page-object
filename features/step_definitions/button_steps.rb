When /^I click the button$/ do
  @page.button_id
end

When /^I click the button with type image$/ do
  @page.button_image_id
end

When /^I click the image button using src$/ do
  @page.button_image_src
end

When /^I click the image button using alt$/ do
  @page.button_image_alt
end

When /^I search for the button by "([^\"]*)"$/ do |how|
  @how = how
end

When /^I search for the button by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @how = "#{param1}_#{param2}"
end

Then /^I should be able to click the button$/ do
  @page.send "button_#{@how}"
end

Then /^I should be able to click the real button$/ do
  @page.send "btn_#{@how}"
end

When /^I find a button while the script is executing$/ do
  @button = @page.button_element(:id => 'button_id')
end

Then /^I should be able to click the button element$/ do
  @button.click
end

Then /^I should see that the button exists$/ do
  @page.button_id?.should == true
end
