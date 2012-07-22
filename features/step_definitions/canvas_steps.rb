When /^I search for the canvas by "([^\"]*)"$/ do |how|
  @element = @page.send "canvas_#{how}_element"
end
