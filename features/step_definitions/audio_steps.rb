When /^I search for the audio element by "([^\"]*)"$/ do |how|
  @element = @page.send "audio_#{how}_element"
end

When /^I search for the audio element by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @element = @page.send "audio_#{param1}_#{param2}_element"
end
