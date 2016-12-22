
When /^I get the text from the paragraph$/ do
  @text = @page.p_id
end

When /^I search for the paragraph by "([^"]*)"$/ do |how|
  @text = @page.send "p_#{how}".to_sym
end

When /^I search for the paragraph by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @text = @page.send "p_#{param1}_#{param2}"
end

When /^I get the text from a paragraph while the script is executing$/ do
  @text = @page.paragraph_element(:id => 'p_id').text
end

Then /^I should see that the paragraph exists$/ do
  expect(@page.p_id?).to eql true
end

Then(/^I should know the paragraph class is "(.*?)"$/) do |class_name|
  expect(@page.p_id_element.class_name).to eql class_name
end

Then(/^I should be able to select "(.*?)" from the paragraph$/) do |text|
  @page.p_id_element.select_text text
end
