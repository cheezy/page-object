require 'spec_helper'
require 'page-object/page_factory'

class TestPageObject
  include PageObject
  page_url "http://google.com"
end

class TestWorld
  include PageObject::PageFactory
  
  attr_accessor :browser
end

describe PageObject::PageFactory do
  before(:each) do
    @world = TestWorld.new
    @world.browser = mock_watir_browser
  end
  
  it "should create a new page object and execute a block" do
    @world.browser.should_not_receive(:goto)
    @world.on_page TestPageObject do |page|
      page.should be_instance_of TestPageObject
    end
  end
  
  it "should create and visit a new page" do
    @world.browser.should_receive(:goto)
    @world.visit_page TestPageObject do |page|
      page.should be_instance_of TestPageObject
    end
  end
end