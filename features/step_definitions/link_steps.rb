When /^I select the link labeled "([^\"]*)"$/ do |text|
  @page.google_search_id
end

When /^I search for the link by "([^\"]*)"$/ do |how|
  @how = how
end

Then /^I should be able to select the link$/ do
  @page.send "google_search_#{@how}".to_sym
end

When /^I select a link labeled "([^"]*)" and index "([^"]*)"$/ do |label, index|
  @page.send "#{label.downcase}#{index}".to_sym
end

When /^I select a link while the script is executing$/ do
  link = @page.link_element(:id => 'link_id')
  link.click
end

Then /^I should see that the link exists$/ do
  @page.link_id?.should == true
end