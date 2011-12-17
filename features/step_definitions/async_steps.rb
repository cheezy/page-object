def success

end

Then /^I should be able to wait until it is present$/ do
  @element.when_present do
    success
  end
end

Then /^I should be able to wait until it is visible$/ do
  @element.when_visible do
    success
  end
end

Then /^I should be able to wait until it is not visible$/ do
  begin
    @element.when_not_visible do
      fail
    end
  rescue
    success
  end
end

Then /^I should be able to wait until a block returns true$/ do
  @element.wait_until do
    @element.visible?
  end
end

class AsyncPage
  include PageObject
  button(:target, :value => 'Target')
  button(:hide, :value => 'Hide Button')
  button(:unhide, :value => 'Unhide Button')
end

Given /^I am on the async elements page$/ do
  @page = AsyncPage.new(@browser)
  @page.navigate_to(UrlHelper.async)
end

When /^I make the button invisible$/ do
  @page.hide
  sleep 2
end

Then /^I should be able to click it when it becomses visible$/ do
  @page.unhide
  @page.target_element.when_visible do
    @page.target
  end
end

Then /^I should be able to wait until the button becomes invisible$/ do
  @page.hide
  @page.target_element.when_not_visible do
    @page.target_element.attribute("block").should == "none"
  end
end
