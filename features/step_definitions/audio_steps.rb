When /^I search for the audio element by "([^\"]*)"$/ do |how|
  @element = @avpage.send "audio_#{how}_element"
end

When /^I search for the audio element by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @element = @avpage.send "audio_#{param1}_#{param2}_element"
end

When /^I retrieve the audio element from the page$/ do 
  @element = @avpage.audio_id_element
end

Then /^I should know the audio is not autoplay$/ do
  @element.should_not be_autoplay
end

Then /^I should know that the controls are displayed$/ do
  @element.should have_controls
end

Then /^I should know that the audio is paused$/ do
  @element.should be_paused
end

Then /^I should know that its volume is (\d+)$/ do |volume|
  @element.volume.should == volume.to_i
end
