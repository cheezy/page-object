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
