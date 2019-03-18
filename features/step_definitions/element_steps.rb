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
  expect(@element.exists?).to be true
end

Then /^I should know it is visible$/ do
  expect(@element.present?).to be true
end

Then /^I should know it is not visible$/ do
  expect(@element.present?).to be false
end

Then /^I should know the text is "(.*)"$/ do |text|
  expect(@element.text).to eql text
end

Then /^I should know the html is "(.*)"$/ do |html|
  expect(@element.html).to eql html
end

Then /^I should know the text includes "(.*)"$/ do |text|
  expect(@element.text).to include text
end

Then /^I should know the value is "(.*)"$/ do |value|
  expect(@element.value).to eql value
end

Then /^I should know it is equal to itself$/ do
  expect(@element).to eql @element
end

Then /^I should know the tag name is "(.+)"$/ do |tagname|
  expect(@element.tag_name).to eql tagname
end

Then /^I should know the attribute "(.+)" is false$/ do |attr_name|
  @attr = @element.attribute(attr_name)
  expect(@attr).to be false if @attr.is_a? FalseClass
  expect(@attr).to eql "false" if @attr.is_a? String
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
  expect(@element.enabled?).to be true
end

When /^I check a disabled button$/ do
  @element = @page.disabled_button_element
end

Then /^it should know it is not enabled$/ do
  expect(@element.enabled?).not_to be true
end

Then /^it should know that is it not disabled$/ do
  expect(@element).not_to be_disabled
end

Then /^it should know that it is disabled$/ do
  expect(@element).to be_disabled
end

When /^I set the focus to the test text_field using the onfocus event$/ do
  @page.text_field_element(:id => 'onfocus_text_field').fire_event('onfocus')
end

Then /^I should see the onfocus text "([^\"]*)"$/ do |text|
  expect(@page.div_element(:id => 'onfocus_test').text).to eql text
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
  expect(@parent).to be_instance_of ::PageObject::Elements::Div
end

Then /^I should know that the text_field has the focus$/ do
  element = @page.element_with_focus
  expect(element.focused?).to be true
  expect(element.class).to eql PageObject::Elements::TextField
end

When /^I set the focus to the test text_field$/ do
  @page.text_field_element(:id => 'onfocus_text_field').focus
end

When /^I set the focus off the test text_field$/ do
  @page.text_field_unfocus_element.focus
end

When /^I retrieve the focus state of the text_field$/ do
  @focused_state = @page.text_field_onfocus_element.focused?
end

When /^I should know that the text_field is focused$/ do
  expect(@focused_state).to be true
end

When /^I should know that the text_field is not focused$/ do
  expect(@focused_state).to be false
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
  expect(@page.hello_element.style('font-size')).to eql font_size if ENV['BROWSER'] == 'chrome'
end

Then /^I should know its id is "([^\"]*)"$/ do |id|
  expect(@element.id).to eql id
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
  expect(@page.p_text).to eql expected_text
end

When /^I scroll the heading element into view$/ do
  @element.scroll_into_view
end

Then /^the heading element should be visible$/ do
  expect(@element.visible?).to be true
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
  expect(@element.image_element).not_to be_nil
end

Then(/^I should know the attribute "(.*?)" includes "(.+)"$/) do |attribute, included|
  @attr = @element.attribute(attribute)
  expect(@attr).to include included
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
  expect(@element.height.is_a? Integer).to be true
  expect(@element.height).to be > 0
end

Then(/the element width is not 0/) do
  expect(@element.width.is_a? Integer).to be true
  expect(@element.width).to be > 0
end

Then(/the element centre should be greater than element y position/) do
  expect(@element.centre['y']).to be > @element.location.y
end

Then(/the element centre should be greater than element x position/) do
  expect(@element.centre['x']).to be > @element.location.x
end

When(/^I retrieve a table element with regex characters$/) do
  @element = @page.table_with_regex_element
end
