require 'spec_helper'

describe PageObject::Platforms::WatirWebDriver do
  
  it "should be in the PageObjects Adapters list" do
    expect(PageObject::Platforms.get[:watir_webdriver]).to be PageObject::Platforms::WatirWebDriver
  end
  
end
