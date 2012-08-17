
When /^I retrieve the video element$/ do
  @element = @page.video_id_element
end

When /^I search for the video element by "([^\"]*)"$/ do |how|
  @element = @page.send "video_#{how}_element"
end

When /^I search for the video element by "([^\"]*)" and "([^\"]*)"$/ do |param1, param2|
  @element = @page.send "video_#{param1}_#{param2}_element"
end
