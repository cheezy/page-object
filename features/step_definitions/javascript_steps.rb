class JavascriptPage
  include PageObject

  text_field(:expression, :id => 'calculator-expression')
  text_field(:results, :id => 'calculator-result')
  button(:compute, :value => 'Compute')

end

Given /^I am on jQuery example page$/ do
  PageObject.javascript_framework = :jquery
  @page = JavascriptPage.new(@browser)
  @page.navigate_to "http://localhost:4567/jquery.html"
end

Given /^I am on the Prototype example page$/ do
  PageObject.javascript_framework = :prototype
  @page = JavascriptPage.new(@browser)
  @page.navigate_to "http://localhost:4567/prototype.html"
end

When /^I ask to compute "([^\"]*)"$/ do |expression|
  @page.expression = expression
  @page.compute
end

Then /^I should be able to wait for the answer "([^\"]*)"$/ do |answer|
  @page.wait_for_ajax
  @page.results.should == answer
end

Given /^I execute the javascript "([^\"]*)"$/ do |script|
  @answer = @page.execute_script script
end

Then /^I should get the answer "([^\"]*)"$/ do |answer|
  @answer.should == answer.to_i
end
