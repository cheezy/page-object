Given /^I am on the static elements page$/ do
  @page = Page.new(@browser)
  @page.navigate_to(UrlHelper.static_elements)
end

Given /^I am on the audio video page$/ do
  @avpage = visit AudioVideoPage
end
