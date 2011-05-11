
Then /^the page should contain the text "([^\"]*)"$/ do |text|
  @page.text.should == text  
end
