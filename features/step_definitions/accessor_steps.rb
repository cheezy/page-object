Then /^the current item should be "([^\"]*)"$/ do |expected_text|
  expect(@page.sel_list_id).to eql expected_text
end

Then /^the text should be "([^\"]*)"$/ do |expected_text|
  expect(@text.tr("\n", ' ')).to eql expected_text
end

Then /^the text should include "([^\"]*)"$/ do |expected_text|
  expect(@text).to include expected_text
end

Then /^I should be on the success page$/ do
  expect(@page.text).to include 'Success'
  expect(@page.title).to eql 'Success'
end

Then /^the list items text should be "([^\"]*)"$/ do |expected_text|
  expect(@element.text).to eql expected_text
end

When /^I get the first item from the list$/ do
  @element = @list[0]
end

Then /^the table should have "([^\"]*)" rows$/ do |rows|
  expect(@element.rows).to eql rows.to_i
end

Then /^each row should contain "([^\"]*)"$/ do |text|
  @element.each do |row|
    expect(row.text).to include text
  end
end

Then /^row "([^\"]*)" should have "([^\"]*)" columns$/ do |row, cols|
  expect(@element[row.to_i - 1].columns).to eql cols.to_i
end

Then /^each column should contain "([^\"]*)"$/ do |text|
  row = @element[0]
  row.each do |column|
    expect(column.text).to include text
  end
end

Then /^the list should contain (\d+) items$/ do |items|
  expect(@list.items).to eql items.to_i
end

Then /^each item should contain "([^\"]*)"$/ do |text|
  @list.each { |item| expect(item.text).to include text }
end

Then /^option "([^\"]*)" should contain "([^\"]*)"$/ do |opt_num, text|
  @element = @page.send "sel_list_#{@how}_element".to_sym
  expect(@element[opt_num.to_i - 1].text).to eql text
end

Then /^each option should contain "([^\"]*)"$/ do |text|
  @element.options.each do |option|
    expect(option.text).to include text
  end
end
