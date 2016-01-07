When /^I retrieve a check box element$/ do
  @element = @page.cb_id_element
end

When /^I retrieve a link element$/ do
  @element = @page.google_search_id_element
end

When /^I retrieve a radio button$/ do
  @element = @page.milk_id_element
end

When /^I retrieve a select list$/ do
  @element = @page.sel_list_id_element
end

When /^I retrieve a text field$/ do
  @element = @page.text_field_id_element
end

When /^I retrieve the text area$/ do
  @element = @page.text_area_id_element
end

When /^I retrieve the div element$/ do
  @element = @page.div_id_element
end

When /^I retrieve a table element$/ do
  @element = @page.table_id_element
end

When /^I retrieve a table with thead element$/ do
  @element = @page.table_with_thead_id_element
end

When /^I retrieve a button element$/ do
  @element = @page.button_id_element
end

When /^I retrieve table cell$/ do
  @element = @page.cell_id_element
end

When /^I retrieve a heading element$/ do
  @element = @page.h1_id_element
end

When /^I retrieve the area element$/ do
  @element = @page.area_id_element
end

When /^I retrieve the canvas element$/ do
  @element = @page.canvas_id_element
end

When /^I retrieve the audio element$/ do
  @element = @page.audio_id_element
end

When /^I locate the form$/ do
  @element = @page.form_id_element
end

Then /^I should know it exists$/ do
  @element.should exist
end

Then /^I should know it is visible$/ do
  @element.should be_visible
end

Then /^I should know it is not visible$/ do
  @element.should_not be_visible
end

Then /^I should know the text is "(.*)"$/ do |text|
  @element.text.should == text
end

Then /^I should know the html is "(.*)"$/ do |html|
  @element.html.should == html
end

Then /^I should know the text includes "(.*)"$/ do |text|
  @element.text.should include text
end

Then /^I should know the value is "(.*)"$/ do |value|
  @element.value.should == value
end

Then /^I should know the value is nil$/ do
  @element.value.should be_nil
end

Then /^I should know it is equal to itself$/ do
  @element.should == @element
end

Then /^I should know the tag name is "(.+)"$/ do |tagname|
  @element.tag_name.should == tagname
end

Then /^I should know the attribute "(.+)" is false$/ do |attr_name|
  @attr = @element.attribute(attr_name)
  @attr.should be_false if @attr.is_a? FalseClass
  @attr.should == "false" if @attr.is_a? String
end

Then /^I should be able to click it$/ do
  @element.click
end

When /^I retrieve a list item element$/ do
  @element = @page.li_id_element
end

When /^I retrieve an unordered list element$/ do
  @element = @page.ul_id_element
end

When /^I retrieve an ordered list element$/ do
  @element = @page.ol_id_element
end

When /^I clear the text field$/ do
  @page.text_field_id_element.clear
end

When /^I check an enabled button$/ do
  @element = @page.button_id_element
end

Then /^it should know it is enabled$/ do
  @element.should be_enabled
end

When /^I check a disabled button$/ do
  @element = @page.disabled_button_element
end

Then /^it should know it is not enabled$/ do
  @element.should_not be_enabled
end

Then /^it should know that is it not disabled$/ do
  @element.should_not be_disabled
end

Then /^it should know that it is disabled$/ do
  @element.should be_disabled
end

When /^I set the focus to the test text_field using the onfocus event$/ do
  @page.text_field_element(:id => 'onfocus_text_field').fire_event('onfocus')
end

Then /^I should see the onfocus text "([^\"]*)"$/ do |text|
  @page.div_element(:id => 'onfocus_test').text.should == text
end

When /^I set the focus on the test text_field$/ do
  @page.text_field_element(:id => 'onfocus_text_field').focus
end

When /^I find the child link element$/ do
  @element = @page.child_element
end

When /^ask for the parent element$/ do
  @parent = @element.parent
end

Then /^I should have a div parent$/ do
  @parent.should be_instance_of ::PageObject::Elements::Div
end

Then /^I should know that the text_field has the focus$/ do
  element = @page.element_with_focus
  element.should_not be_nil
  element.class.should == PageObject::Elements::TextField
end

When /^I set the focus to the test text_field$/ do
  @page.text_field_element(:id => 'onfocus_text_field').focus
end

When /^I retrieve the label element$/ do
  @element = @page.label_id_element
end

Then /^I should be able to flash it$/ do
  @element.flash
end

class HoverPage
  include PageObject

  link(:hello)
end

Given /^I am on the hover page$/ do
  @page = HoverPage.new(@browser)
  @page.navigate_to UrlHelper.hover
end

When /^I hover over the hello link$/ do
  @page.hello_element.hover
end

Then /^the font size should be "([^\"]*)"$/ do |font_size|
  @page.hello_element.style('font-size').should == font_size if ENV['BROWSER'] == 'chrome'
end

Then /^I should know its id is "([^\"]*)"$/ do |id|
  @element.id.should == id
end

class DoubleClickPage
  include PageObject
  button(:click)
  paragraph(:p_text)
end

Given /^I am on the Double Click page$/ do
  @page = DoubleClickPage.new(@browser)
  @page.navigate_to UrlHelper.double_click
end

When /^I double click the button$/ do
  @page.click_element.double_click
end

Then /^the paragraph should read "([^\"]*)"$/ do |expected_text|
  @page.p_text.should == expected_text
end

When /^I scroll the heading element into view$/ do
  @element.scroll_into_view
end

Then /^the heading element should be visible$/ do
  @element.should be_visible
end

When /^I retrieve a div using data\-entity$/ do
  @element = @page.div_data_entity_element
end

When(/^I retrieve the figure using the declaration$/) do
  @element = @page.figure_id_element
end

When(/^I retrieve the figure using the element$/) do
  @element = @page.figure_element(:id => 'figure_id')
end

Then(/^I should see the figure contains an image$/) do
  @element.image_element.should_not be_nil
end

Then(/^I should know the attribute "(.*?)" includes "(.+)"$/) do |attribute, included|
  @attr = @element.attribute(attribute)
  @attr.should include included
end

Then(/^I should be able to know its location$/) do
  expect(@element.location.y).to be > 0
  expect(@element.location.x).to be > 0
end

Then(/^I should be able to know its size$/) do
  expect(@element.size.width).to be > 0
  expect(@element.size.height).to be > 0
end

Then(/the element height is not 0/) do
  (@element.height.is_a? Integer).should ==true
  @element.height.should > 0
end

Then(/the element width is not 0/) do
  (@element.width.is_a? Integer).should ==true
  @element.width.should > 0
end

Then(/the element centre should be greater than element y position/) do
  @element.centre['y'].should > @element.location.y
end

Then(/the element centre should be greater than element x position/) do
  @element.centre['x'].should > @element.location.x
end
