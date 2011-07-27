require 'spec_helper'

describe PageObject::Adapters::Watir do
  it "should be in the PageObjects Adapters list" do
    PageObject::Adapters.get[:watir].should be PageObject::Adapters::Watir
  end
  describe "create page object" do
    let(:browser) { double('browser') }
    let(:subject) { PageObject::Adapters::Watir.create_page_object(browser) }
    it "should create a WatirPageObject" do
      subject.should be_kind_of PageObject::WatirPageObject
    end
    it "should give the watir page object the browser" do
      subject.browser.should be browser
    end
  end 
end
