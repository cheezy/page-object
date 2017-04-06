require 'spec_helper'

describe PageObject::Platforms::Watir do
  describe "is for?" do
    it "should be true when the browser is Watir::Browser" do
      browser = mock_watir_browser
      expect(PageObject::Platforms::Watir.is_for?(browser)).to be true
    end
    
    it "should be false at any other point" do
      browser = 'asdf'
      expect(PageObject::Platforms::Watir.is_for?('asdf')).to be false
    end
  end
end

