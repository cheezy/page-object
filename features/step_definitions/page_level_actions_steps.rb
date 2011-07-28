Then /^the page should contain the text "([^\"]*)"$/ do |text|
  @page.text.should include text
end

Then /^the page should contain the html "([^\"]*)"$/ do |html|
  @page.html.should include html
end

Then /^the page should have the title "([^\"]*)"$/ do |title|
  @page.title.should include title
end

Then /^I should be able to wait for a block to return true$/ do
  @page.google_search_id
  @page.wait_until(10, "too long to display page") do
    @page.text.include? 'Success'
  end
end

When /^I handle the alert$/ do
  @msg = @page.alert do
    @page.alert_button
  end
end

Then /^I should be able to get the alert's message$/ do
  @msg.should == "I am an alert"
end

When /^I handle the confirm$/ do
  @msg = @page.confirm(true) do
    @page.confirm_button
  end
end

Then /^I should be able to get the confirm message$/ do
  @msg.should == 'set the value'
end

When /^I handle the prompt$/ do
  @msg = @page.prompt("Cheezy") do
    @page.prompt_button
  end
end

Then /^I should be able to get the message and default value$/ do
  @msg[:message].should == "enter your name"
  @msg[:default_value].should == 'John Doe'
end

