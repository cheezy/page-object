module Target
  def watir_browser
    Watir::Browser.new :firefox
  end

  def selenium_browser
    Selenium::WebDriver.for :firefox
  end
end
