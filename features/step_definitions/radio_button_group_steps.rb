When /^no radio buttons have been selected$/ do
  # nothing to do here
end

Then /^no radio buttons should be selected in the group$/ do
  @page.favorite_cheese_selected?.should == false
end

When /^I select the "([^\"]*)" radio button in the group$/ do |how|
  @page.select_favorite_cheese("#{how}")
end

Then /^the "([^\"]*)" radio button should be selected in the group$/ do |how|
  @page.favorite_cheese_selected?.should == "#{how}"
end

Then /^the "([^\"]*)" radio button should not be selected$/ do |how|
  @page.favorite_cheese_selected?.should_not == "#{how}"
end

Then /^I should see that the radio button group exists$/ do
  @page.favorite_cheese?.should == true
end

When /^I ask for the elements of a radio button group$/ do
  @elems = @page.favorite_cheese_elements
end

Then /^I should have an array with elements for each radio button$/ do
  @elems.length.should == 3
end

And /^the radio button element values should be "([^\"]*)", "([^\"]*)", "([^\"]*)"$/ do |val1, val2, val3|
  elem_arr = @elems.collect { |elem| elem.value }
  elem_arr.should == [val1, val2, val3]
end