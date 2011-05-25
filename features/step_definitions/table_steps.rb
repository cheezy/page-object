Then /^the data for row "([^"]*)" should be "([^"]*)" and "([^"]*)"$/ do |row, col1, col2|
  table_row = @element[row.to_i - 1]
  table_row[0].should == col1
  table_row[1].should == col2
end


When /^I retrieve the data from the table cell$/ do
  @cell_data = @page.cell_id
end

Then /^the cell data should be '([^"]*)'$/ do |expected|
  @cell_data.should == expected
end
