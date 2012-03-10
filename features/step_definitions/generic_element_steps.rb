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
