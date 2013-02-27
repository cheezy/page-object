When /^I get the text from the article$/ do
  @text = @page.article_id
end

When /^I get the text from the header$/ do
  @text = @page.header_id
end

When /^I get the text from the footer$/ do
	@text = @page.footer_id
end

When /^I get the text from the summary$/ do
	@text = @page.summary_id
end

When /^I get the text from the details$/ do
	@text = @page.details_id
end

When /^I get the svg element$/ do
  @svg = @page.svg_id_element
end

Then /^the svg width should be "(.*?)"$/ do |width|
  @svg.attribute('width').should == width
end

Then /^the svg height should be "(.*?)"$/ do |height|
  @svg.attribute('height').should == height
end
