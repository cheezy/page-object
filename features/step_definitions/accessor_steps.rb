When /^I type "([^\"]*)" into the text area$/ do |text|
  @page.text_area_id = text
end

Then /^the text area should contain "([^\"]*)"$/ do |expected_text|
  @page.text_area_id.should == expected_text
end

When /^I search for the text area by "([^\"]*)"$/ do |how|
  @how = how
end

When /^I search for the text area by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @how = "#{param1}_#{param2}"
end

Then /^I should be able to type "([^\"]*)" into the area$/ do |value|
  @page.send "text_area_#{@how}=".to_sym, value
end

When /^I select the link labeled "([^\"]*)"$/ do |text|
  @page.google_search_id
end

When /^I search for the link by "([^\"]*)"$/ do |how|
  @how = how
end

Then /^I should be able to select the link$/ do
  @page.send "google_search_#{@how}".to_sym
end

When /^I select "([^\"]*)" from the select list$/ do |text|
  @page.sel_list_id = text
end

Then /^the current item should be "([^\"]*)"$/ do |expected_text|
  @page.sel_list_id.should == expected_text
end

When /^I search for the select list by "([^\"]*)"$/ do |how|
  @how = how
end

When /^I search for the select list by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @how = "#{param1}_#{param2}"
end

Then /^I should be able to select "([^\"]*)"$/ do |value|
  @page.send "sel_list_#{@how}=".to_sym, value
end

Then /^the value for the selected item should be "([^\"]*)"$/ do |value|
  result = @page.send "sel_list_#{@how}".to_sym
  result.should == value
end

When /^I select the First check box$/ do
  @page.check_cb_id
end

Then /^the First check box should be selected$/ do
  @page.cb_id_checked?.should be_true
end

When /^I unselect the First check box$/ do
  @page.uncheck_cb_id
end

Then /^the First check box should not be selected$/ do
  @page.cb_id_checked?.should be_false
end

When /^I search for the check box by "([^\"]*)"$/ do |how|
  @how = how
end

When /^I search for the check box by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @how = "#{param1}_#{param2}"
end

Then /^I should be able to check the check box$/ do
  @page.send "check_cb_#{@how}".to_sym
end

When /^I select the "([^\"]*)" radio button$/ do |how|
  @page.send "select_#{how.downcase}_id".to_sym
end

Then /^the "([^\"]*)" radio button should be selected$/ do |how|
  @page.send "#{how.downcase}_id_selected?".to_sym
end

When /^I search for the radio button by "([^\"]*)"$/ do |how|
  @how = how
end

When /^I search for the radio button by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @how = "#{param1}_#{param2}"
end

When /^I select the radio button$/ do
  @page.send "select_milk_#{@how}".to_sym
end

When /^I get the text from the div$/ do
  @text = @page.div_id
end

Then /^the text should be "([^\"]*)"$/ do |expected_text|
  @text.should == expected_text
end

When /^I search for the div by "([^\"]*)"$/ do |how|
  @text = @page.send "div_#{how}".to_sym
end

When /^I search for the div by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @text = @page.send "div_#{param1}_#{param2}".to_sym
end

When /^I get the text from the span$/ do
  @text = @page.span_id
end

When /^I search for the span by "([^\"]*)"$/ do |how|
  @text = @page.send "span_#{how}".to_sym
end

When /^I search for the span by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @text = @page.send "span_#{param1}_#{param2}".to_sym
end

Then /^I should be on the success page$/ do
  @page.text.should include 'Success'
  @page.title.should == 'Success'
end

When /^I search for the table cell by "([^\"]*)"$/ do |how|
  @cell_data = @page.send "cell_#{how}"
end

When /^I retrieve a table cell element by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @cell_data = @page.send "cell_#{param1}_#{param2}"
end

When /^I retrieve a table element by "([^\"]*)"$/ do |how|
  @element = @page.send "table_#{how}_element"
end

When /^I retrieve a table element by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @element = @page.send "table_#{param1}_#{param2}_element"
end

When /^I get the image element$/ do
  @element = @page.image_id_image
end

Then /^the image should be "([^\"]*)" pixels wide$/ do |width|
  @element.width.should == width.to_i
end

Then /^the image should be "([^\"]*)" pixels tall$/ do |height|
  @element.height.should == height.to_i
end

When /^I get the image element by "([^\"]*)"$/ do |how|
  @element = @page.send "image_#{how}_element"
end

When /^I get the image element by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @element = @page.send "image_#{param1}_#{param2}_element"
end

Then /^I should be able to submit the form$/ do
  @element.submit
end

When /^I locate the form by "([^\"]*)"$/ do |how|
  @element = @page.send "form_#{how}_element"
end

When /^I locate the form using "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @element = @page.send "form_#{param1}_#{param2}_element"
end

When /^I get the text from the list item$/ do
  @text = @page.li_id
end

When /^I search for the list item by "([^\"]*)"$/ do |how|
  @text = @page.send "li_#{how}"
end

When /^I search for the list item by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @text = @page.send "li_#{param1}_#{param2}"
end

When /^I get the first item from the unordered list$/ do
  @element = @page.ul_id_element[0]
end

Then /^the list items text should be "([^\"]*)"$/ do |expected_text|
  @element.text.should == expected_text
end

When /^I search for the unordered list by "([^\"]*)"$/ do |how|
  @list = @page.send "ul_#{how}_element"
end

When /^I search for the unordered list by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @list = @page.send "ul_#{param1}_#{param2}_element"
end


When /^I get the first item from the list$/ do
  @element = @list[0]
end

When /^I get the first item from the ordered list$/ do
  @element = @page.ol_id_element[0]
end

When /^I search for the ordered list by "([^\"]*)"$/ do |how|
  @list = @page.send "ol_#{how}_element"
end

When /^I search for the ordered list by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @list = @page.send "ol_#{param1}_#{param2}_element"
end

Then /^the table should have "([^\"]*)" rows$/ do |rows|
  @element.rows.should == rows.to_i
end

Then /^each row should contain "([^\"]*)"$/ do |text|
  @element.each do |row|
    row.text.should include text
  end
end

Then /^row "([^\"]*)" should have "([^\"]*)" columns$/ do |row, cols|
  @element[row.to_i - 1].columns.should == cols.to_i
end

Then /^each column should contain "([^\"]*)"$/ do |text|
  row = @element[0]
  row.each do |column|
    column.text.should include text
  end
end

Then /^the list should contain (\d+) items$/ do |items|
  @list.items.should == items.to_i
end

Then /^each item should contain "([^\"]*)"$/ do |text|
  @list.each { |item| item.text.should include text }
end

Then /^option "([^\"]*)" should contain "([^\"]*)"$/ do |opt_num, text|
  @element = @page.send "sel_list_#{@how}_element".to_sym
  @element[opt_num.to_i - 1].text.should == text
end

Then /^each option should contain "([^\"]*)"$/ do |text|
  @element.options.each do |option|
    option.text.should include text
  end
end
