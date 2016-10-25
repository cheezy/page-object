Then /^the current item should be "([^\"]*)"$/ do |expected_text|
  @page.sel_list_id.should == expected_text
end

Then /^the text should be "([^\"]*)"$/ do |expected_text|
  @text.tr("\n", ' ').should == expected_text
end

Then /^the text should include "([^\"]*)"$/ do |expected_text|
  expect(@text).to include expected_text
end

Then /^I should be on the success page$/ do
  @page.text.should include 'Success'
  @page.title.should == 'Success'
end

Then /^the list items text should be "([^\"]*)"$/ do |expected_text|
  @element.text.should == expected_text
end

When /^I get the first item from the list$/ do
  @element = @list[0]
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
