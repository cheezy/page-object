Then /^I should be able to submit the form$/ do
  @element.submit
end

When /^I locate the form by "([^\"]*)"$/ do |how|
  @element = @page.send "form_#{how}_element"
end

When /^I locate the form using "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @element = @page.send "form_#{param1}_#{param2}_element"
end

When /^I locate a form while the script is executing$/ do
  @element = @page.form_element(:id => 'form_id')
end

Then /^I should see that the form exists$/ do
  @page.form_id?.should == true
end