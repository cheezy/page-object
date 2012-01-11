When /^I select the First check box$/ do
  @page.check_cb_id
end

Then /^the First check box should be selected$/ do
  @page.cb_id_checked?.should be_true
end

When /^I unselect the First check box$/ do
  @page.uncheck_cb_id
end

Then /^the First check box should not be selected$/ do
  @page.cb_id_checked?.should be_false
end

When /^I search for the check box by "([^\"]*)"$/ do |how|
  @how = how
end

When /^I search for the check box by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @how = "#{param1}_#{param2}"
end

Then /^I should be able to check the check box$/ do
  @page.send "check_cb_#{@how}".to_sym
end

When /^I select the first check box while the script is executing$/ do
  @page.checkbox_element(:id => 'cb_id').check
end

Then /^I should see that the checkbox exists$/ do
  @page.button_id?.should == true
end
