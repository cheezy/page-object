When /^I set the file field to the step definition file$/ do
  @page.file_field_id = __FILE__
end

Then /^its\' value should equal that file$/ do
  __FILE__.should include @page.file_field_id_element.value[/[^\\]*$/]
end

When /^I search for the file field by "([^\"]*)"$/ do |how|
  @how = how
end

When /^I search for the file field by "([^\"]*)" and "([^\"]*)"$/ do |param1, param2|
  @how = "#{param1}_#{param2}"
end

Then /^I should be able to set the file field$/ do
  @page.send "file_field_#{@how}=", __FILE__
end
