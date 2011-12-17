When /^I set the file field to the step definition file$/ do
  @page.file_field_id = __FILE__
end

Then /^its\' value should equal that file$/ do
  @page.file_field_id_element.value.should == __FILE__
end
