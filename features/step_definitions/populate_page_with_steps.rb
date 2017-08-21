When(/^I populate the page with the data:$/) do |table|
  @page.populate_page_with table.rows_hash
end
