
Then /^the page should contain the text "([^\"]*)"$/ do |text|
  @page.text.should include text  
end

Then /^the page should contain the html "([^\"]*)"$/ do |html|
  @page.html.should include html
end

Then /^the page should have the title "([^\"]*)"$/ do |title|
  @page.title.should include title
end
