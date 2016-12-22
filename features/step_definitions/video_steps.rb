
When /^I retrieve the video element$/ do
  @element = @avpage.video_id_element
end

When /^I search for the video element by "([^\"]*)"$/ do |how|
  @element = @avpage.send "video_#{how}_element"
end

When /^I search for the video element by "([^\"]*)" and "([^\"]*)"$/ do |param1, param2|
  @element = @avpage.send "video_#{param1}_#{param2}_element"
end

Then /^I should know the video is not autoplay$/ do
  expect(@element).not_to be_autoplay
end

Then /^I should know that the video is paused$/ do
  expect(@element).to be_paused
end

Then /^I should know that its height is (\d+) pixels$/ do |height|
  expect(@element.height).to eql height.to_i
end

Then /^I should knot what its width is (\d+) pixels$/ do |width|
  expect(@element.width).to eql width.to_i
end

Then /^I should know that it has not ended$/ do
  expect(@element).not_to be_ended
end

Then /^I should know that it is not seeking$/ do
  expect(@element).not_to be_seeking
end

Then /^I should know that it is not in a loop$/ do
  expect(@element).not_to be_loop
end

Then /^I should know that it is muted$/ do
  expect(@element).not_to be_muted
end
