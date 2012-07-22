When /^I search for the canvas by "([^\"]*)"$/ do |how|
  @element = @page.send "canvas_#{how}_element"
end

Then /^I should see that the canvas width is "([^\"]*)"$/ do |width|
  @element.width.should == width.to_i
end

Then /^I should see that the canvas height is "([^\"]*)"$/ do |height|
  @element.height.should == height.to_i
end
