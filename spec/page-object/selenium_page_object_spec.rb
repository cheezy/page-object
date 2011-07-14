require 'spec_helper'
require 'page-object/selenium_page_object'
require 'page-object/elements'

class TestPageObject
  include PageObject
end

describe PageObject::SeleniumPageObject do
  let(:selenium_browser) { mock_selenium_browser }
  let(:selenium_page_object) { TestPageObject.new(selenium_browser) }

  context "when building identifiers hash" do
    it "should add tag_name when identifying by text for hidden_field" do
      expected_identifier = {:text => 'foo', :tag_name => 'input', :type => 'hidden'}
      PageObject::Elements::HiddenField.should_receive(:selenium_identifier_for).with(expected_identifier)
      selenium_browser.should_receive(:find_element)
      selenium_page_object.platform.hidden_field_for(:text => 'foo')
    end
  end
end