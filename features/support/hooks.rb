
Before do
  @browser = PageObject::PersistantBrowser.get_browser
end

at_exit do
  PageObject::PersistantBrowser.quit
end
