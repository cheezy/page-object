require 'spec_helper'
require 'page-object/page_factory'

class FactoryTestPageObject
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
    @world.on_page FactoryTestPageObject do |page|
      page.should be_instance_of FactoryTestPageObject
    end
  end
  
  it "should create and visit a new page" do
    @world.browser.should_receive(:goto)
    @world.visit_page FactoryTestPageObject do |page|
      page.should be_instance_of FactoryTestPageObject
    end
  end
end