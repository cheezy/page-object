When /^I type "([^\"]*)" into the text area$/ do |text|
  @page.text_area_id = text
end

Then /^the text area should contain "([^\"]*)"$/ do |expected_text|
  @page.text_area_id.should == expected_text
end

When /^I search for the text area by "([^\"]*)"$/ do |how|
  @how = how
end

When /^I search for the text area by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @how = "#{param1}_#{param2}"
end

Then /^I should be able to type "([^\"]*)" into the area$/ do |value|
  @page.send "text_area_#{@how}=".to_sym, value
end

When /^I find a text area while the script is executing$/ do
  @text_area = @page.text_area_element(:id => 'text_area_id')
end

Then /^I should be able to type "([^"]*)" into the area element$/ do |value|
  @text_area.value = value
end

When /^I clear the text area$/ do
  @page.text_area_id_element.clear
end

Then /^I should see that the text area exists$/ do
  @page.text_area_id?.should == true
end