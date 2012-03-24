When /^I get the text from the label$/ do
  @text = @page.label_id
end

When /^I search for the label by "([^\"]*)"$/ do |how|
  @text = @page.send "label_#{how}".to_sym
end

When /^I search for the label by "(.*)" and "(.*)"$/ do |param1, param2|
  @text = @page.send "label_#{param1}_#{param2}".to_sym
end

When /^I get the text from a label while the script is executing$/ do
  @text = @page.label_element(:id => 'label_id').text
end

Then /^I should see that the label exists$/ do
  @page.label_id?.should be_true
end
