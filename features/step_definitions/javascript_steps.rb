class JavascriptPage
  include PageObject

  text_field(:expression, :id => 'calculator-expression')
  text_field(:results, :id => 'calculator-result')
  button(:compute, :value => 'Compute')

end

def start_server  
  @server = AjaxTestEnvironment.new
  @server.run
end

Given /^I am on jQuery example page$/ do
  start_server
  PageObject.javascript_framework = :jquery
  @page = JavascriptPage.new(@browser)
  @page.navigate_to "http://localhost:4567/jquery.html"
end

When /^I ask to compute "([^\"]*)"$/ do |expression|
  @page.expression = expression
  @page.compute
end

Then /^I should be able to wait for the answer "([^\"]*)"$/ do |answer|
  @page.wait_for_ajax
  @page.results.should == answer
  @server.stop
end
