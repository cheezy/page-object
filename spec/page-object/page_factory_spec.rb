require 'spec_helper'
require 'page-object/page_factory'

class FactoryTestPage
  include PageObject
  page_url "http://google.com"
  navigation_method :a_method
end

class AnotherPage
  include PageObject
  navigation_method :b_method
end

class YetAnotherPage
  include PageObject
  navigation_method :c_method
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
    @world.on_page FactoryTestPage do |page|
      page.should be_instance_of FactoryTestPage
    end
  end

  it "should create and visit a new page" do
    @world.browser.should_receive(:goto)
    @world.visit_page FactoryTestPage do |page|
      page.should be_instance_of FactoryTestPage
    end
  end
  
  it "should set an instance variable that can be used outside of the block" do
    page = @world.on_page FactoryTestPage
    current_page = @world.instance_variable_get "@current_page"
    current_page.should === page
  end

  it "should raise an error when you do not provide a default route" do
    expect { PageObject::PageFactory.routes = {:another => []} }.to raise_error
  end

  it "should store the routes" do
    routes = ['a', 'b', 'c']
    PageObject::PageFactory.routes = {:default => routes}
    PageObject::PageFactory.page_object_routes[:default].should == routes
  end

  it "should navigate to a page calling the default methods" do
    pages = [FactoryTestPage, AnotherPage]
    PageObject::PageFactory.routes = {:default => pages}
    fake_page = double('a_page')
    FactoryTestPage.should_receive(:new).and_return(fake_page)
    fake_page.should_receive(:a_method)
    @world.navigate_to(AnotherPage).class.should == AnotherPage
  end

  it "should fail when it does not find a proper route" do
    PageObject::PageFactory.routes = {:default => ['a'], :another => ['b']}
    expect { @world.navigate_to(AnotherPage, :using => :no_route) }.to raise_error
  end

  it "should fail when no default method specified" do
    PageObject::PageFactory.routes = {:default => [FactoryTestPage, AnotherPage]}
    fake_page = double('a_page')
    FactoryTestPage.should_receive(:new).and_return(fake_page)
    fake_page.should_receive(:respond_to?).with(:a_method).and_return(false)
    expect { @world.navigate_to(AnotherPage) }.to raise_error
  end

  it "should know how to continue routng from a location" do
    PageObject::PageFactory.routes = {:default => [FactoryTestPage, AnotherPage, YetAnotherPage]}
    fake_page = double('a_page')
    FactoryTestPage.should_not_receive(:new)
    AnotherPage.should_receive(:new).and_return(fake_page)
    fake_page.should_receive(:respond_to?).with(:b_method).and_return(true)
    fake_page.should_receive(:b_method)
    fake_page.should_receive(:class).and_return(FactoryTestPage)
    @world.instance_variable_set :@current_page, fake_page
    @world.continue_navigation_to(YetAnotherPage).class.should == YetAnotherPage
  end
end
