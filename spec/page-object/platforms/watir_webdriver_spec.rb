require 'spec_helper'

describe PageObject::Platforms::WatirWebDriver do
  
  it "should be in the PageObjects Adapters list" do
    PageObject::Platforms.get[:watir_webdriver].should be PageObject::Platforms::WatirWebDriver
  end
  
end
