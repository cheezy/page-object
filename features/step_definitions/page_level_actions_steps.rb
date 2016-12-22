Then /^the page should contain the text "([^\"]*)"$/ do |text|
  expect(@page.text).to include text
end

Then /^the page should contain the html "([^\"]*)"$/ do |html|
  expect(@page.html).to include html
end

Then /^the page should have the title "([^\"]*)"$/ do |title|
  expect(@page.title).to include title
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

When /^I handle the possible alert$/ do
  @msg = @page.alert do
    @page.alert_button_element.focus
  end
end

When /^I handle the alert that reloads the page$/ do
  @msg = @page.alert do
    @page.alert_button_that_reloads
  end
end

Then /^I should be able to get the alert\'s message$/ do
  expect(@msg).to eql "I am an alert"
end

Then /^I should be able to verify the popup didn\'t have a message$/ do
  expect(@msg).to be_nil
end

When /^I handle the confirm$/ do
  @msg = @page.confirm(true) do
    @page.confirm_button
  end
end

When /^I handle the possible confirm$/ do
  @msg = @page.confirm(true) do
    @page.confirm_button_element.focus
  end
end

When /^I handle the confirm that reloads the page$/ do
  @msg = @page.confirm(true) do
    @page.confirm_button_that_reloads
  end
end

Then /^I should be able to get the confirm message$/ do
  expect(@msg).to eql 'set the value'
end

When /^I handle the prompt$/ do
  @msg = @page.prompt("Cheezy") do
    @page.prompt_button
  end
end

When /^I handle the possible prompt$/ do
  @msg = @page.prompt("Cheezy") do
    @page.prompt_button_element.focus
  end
end

Then /^I should be able to get the message and default value$/ do
  expect(@msg[:message]).to eql "enter your name"
  expect(@msg[:default_value]).to eql 'John Doe'
end

When /^I open a second window$/ do
  @page.open_window
end

When /^I open a third window$/ do
  @page.open_another_window
end

class SecondPage
  include PageObject
end

Then /^I should be able to attach to a page object using title$/ do
  @second_page = SecondPage.new(@browser)
  @second_page.attach_to_window(:title => "Success")
  expect(@second_page.title).to eql "Success"
end

Then /^I should be able to attach to a page object using url$/ do
  @second_page = SecondPage.new(@browser)
  @second_page.attach_to_window(:url => "success.html")
  expect(@second_page.current_url).to include 'success.html'
end

Then /^I should be able to refresh the page$/ do
  @page.refresh
end

When /^I press the back button$/ do
  @page.back
end

When /^I press the forward button$/ do
  @page.forward
end

Then /^the page should have the expected title$/ do
  expect(@page).to have_expected_title
end

Then /^the page should have the expected element$/ do
  expect(@page).to have_expected_element
end

Then /^the page should not have the expected element$/ do
  class FakePage
    include PageObject
    expected_element :blah
  end
  expect(FakePage.new(@browser)).not_to have_expected_element
end
