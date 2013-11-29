class JavascriptPage
  include PageObject

  text_field(:expression, :id => 'calculator-expression')
  text_field(:results, :id => 'calculator-result')
  button(:compute, :value => 'Compute')

end

def build_url(page)
  target = ENV['BROWSER']
  return "http://localhost:4567/#{page}" if target.nil? or target.include? 'local'
  "http://ec2-107-22-131-88.compute-1.amazonaws.com:4567/#{page}"
end

Given /^I am on jQuery example page$/ do
  PageObject.javascript_framework = :jquery
  @page = JavascriptPage.new(@browser)
  @page.navigate_to build_url("jquery.html")
end

Given /^I am on the Prototype example page$/ do
  PageObject.javascript_framework = :prototype
  @page = JavascriptPage.new(@browser)
  @page.navigate_to build_url('prototype.html')
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

Given /^I execute the javascript "([^\"]*)" with an argument of "([^\"]*)"$/ do |script, arg|
  @answer = @page.execute_script script, arg
end

Given /^I execute the javascript "([^\"]*)" with a text field argument$/ do |script|
  text_field = @page.text_field_element(:id => 'text_field_id')
  @page.execute_script(script, text_field)
end

Then /^I should get the answer "([^\"]*)"$/ do |answer|
  @answer.should == answer.to_i
end