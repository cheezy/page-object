When /^I get the first item from the unordered list$/ do
  @element = @page.ul_id_element[0]
end

When /^I search for the unordered list by "([^\"]*)"$/ do |how|
  @list = @page.send "ul_#{how}_element"
end

When /^I search for the unordered list by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @list = @page.send "ul_#{param1}_#{param2}_element"
end

When /^I search for the unordered list while the script is executing$/ do
  @list = @page.unordered_list_element(:id => 'ul_id')
end

