require 'spec_helper'
require 'page-object/page_factory'

class FactoryTestPage
  include PageObject
  page_url "http://google.com"
end

class TestPageWithDirectUrl
  include PageObject
  direct_url "http//google.com"
end

class AnotherPage
  include PageObject
end

class YetAnotherPage
  include PageObject
end

module ContainingModule
  class PageInsideModule
    include PageObject
    page_url "http://google.co.uk"
  end
end

class WorldSuper
  attr_reader :super_called
  def on_page(cls, params={}, visit=false, &block)
    @super_called = true
  end
end


class TestWorld < WorldSuper
  include PageObject::PageFactory
  attr_accessor :browser
  attr_accessor :current_page
end

describe PageObject::PageFactory do
  before(:each) do
    @world = TestWorld.new
    @world.browser = mock_watir_browser
  end

  it "should call super when non page-object class passed " do
    class NoPO
    end
    @world.on(NoPO)
    @world.super_called.should be true
  end

  it "should create a new page object and execute a block" do
    @world.browser.should_not_receive(:goto)
    @world.on_page FactoryTestPage do |page|
      page.should be_instance_of FactoryTestPage
    end
    @world.on_page "FactoryTestPage" do |page|
      page.should be_instance_of FactoryTestPage
    end
    @world.on_page "ContainingModule::PageInsideModule" do |page|
      page.should be_instance_of ContainingModule::PageInsideModule
    end
  end

  it "should create a new page object and execute a block using 'on'" do
    @world.browser.should_not_receive(:goto)
    @world.on FactoryTestPage do |page|
      page.should be_instance_of FactoryTestPage
    end
    @world.on "FactoryTestPage" do |page|
      page.should be_instance_of FactoryTestPage
    end
    @world.on "ContainingModule::PageInsideModule" do |page|
      page.should be_instance_of ContainingModule::PageInsideModule
    end
  end

  it "should create and visit a new page" do
    @world.browser.should_receive(:goto).exactly(3).times
    @world.visit_page FactoryTestPage do |page|
      page.should be_instance_of FactoryTestPage
    end
    @world.visit_page "FactoryTestPage" do |page|
      page.should be_instance_of FactoryTestPage
    end
    @world.visit_page "ContainingModule::PageInsideModule" do |page|
      page.should be_instance_of ContainingModule::PageInsideModule
    end
  end

  it "should merge params with the class level params if provided when visiting" do
    @world.browser.should_receive(:goto)
    FactoryTestPage.params = {:initial => :value}
    @world.visit_page(FactoryTestPage, :using_params => {:new_value => :merged})
    merged = FactoryTestPage.instance_variable_get("@merged_params")
    merged[:initial].should == :value
    merged[:new_value].should == :merged
  end

  it "should use the params in the url when they are provided" do
    class PageUsingParams
      include PageObject
      page_url "http://google.com/<%=params[:value]%>"
    end
    @world.browser.should_receive(:goto).with("http://google.com/PageObject")
    @world.visit_page(PageUsingParams, :using_params => {:value => 'PageObject'})
  end

  it "should use the params as well as interpolated values" do
    class PageUsingParmsAndInterpolated
      include PageObject
      page_url "http://google.com/#{1+2}/<%=params[:value]%>"
    end
    @world.browser.should_receive(:goto).with("http://google.com/3/PageObject")
    @world.visit_page(PageUsingParmsAndInterpolated, :using_params => {:value => 'PageObject'})
  end

  it "should create and visit a new page using 'visit'" do
    @world.browser.should_receive(:goto).exactly(3).times
    @world.visit FactoryTestPage do |page|
      page.should be_instance_of FactoryTestPage
    end
    @world.visit "FactoryTestPage" do |page|
      page.should be_instance_of FactoryTestPage
    end
    @world.visit "ContainingModule::PageInsideModule" do |page|
      page.should be_instance_of ContainingModule::PageInsideModule
    end
  end

  it "should create and visit a new page when url is defined as 'direct_url'" do
    @world.browser.should_receive(:goto)
    @world.visit TestPageWithDirectUrl do |page|
      page.should be_instance_of TestPageWithDirectUrl
    end
  end
  
  it "should set an instance variable that can be used outside of the block" do
    page = @world.on_page FactoryTestPage
    current_page = @world.instance_variable_get "@current_page"
    current_page.should === page
  end

  it "should not execute block if page is not @current_page" do
    @world.instance_variable_set "@current_page", TestPageWithDirectUrl.new(@world.browser)
    @world.if_page(FactoryTestPage) do |page|
      fail
    end
    @world.if_page("FactoryTestPage") do |page|
      fail
    end
    @world.if_page("ContainingModule::PageInsideModule") do |page|
      fail
    end
  end

  it "should return the @current_page if asking for another page" do
    expected = TestPageWithDirectUrl.new(@world.browser)
    @world.instance_variable_set "@current_page", expected
    @world.if_page(FactoryTestPage).should == expected
    @world.if_page("FactoryTestPage").should == expected
    @world.if_page("ContainingModule::PageInsideModule").should == expected
  end

  it "should execute the block when we ask if it is the correct page" do
    @world.instance_variable_set "@current_page", FactoryTestPage.new(@world.browser)
    
    done = false
    @world.if_page(FactoryTestPage) do |page|
      page.should be_instance_of FactoryTestPage
      done = true 
    end
    done.should be true
    
    done = false
    @world.if_page("FactoryTestPage") do |page|
      page.should be_instance_of FactoryTestPage
      done = true
    end
    done.should be true
    
    done = false
    @world.instance_variable_set "@current_page", ContainingModule::PageInsideModule.new(@world.browser) 
    @world.if_page("ContainingModule::PageInsideModule") do |page|
      page.should be_instance_of ContainingModule::PageInsideModule
      done = true
    end
    done.should be true
  end

  it "should raise an error when you do not provide a default route" do
    expect { PageObject::PageFactory.routes = {:another => []} }.to raise_error
  end

  it "should store the routes" do
    routes = ['a', 'b', 'c']
    PageObject::PageFactory.routes = {:default => routes}
    PageObject::PageFactory.routes[:default].should == routes
  end

  it "should navigate to a page calling the default methods" do
    pages = [[FactoryTestPage, :a_method], [AnotherPage, :b_method]]
    PageObject::PageFactory.routes = {:default => pages}
    fake_page = double('a_page')
    FactoryTestPage.should_receive(:new).and_return(fake_page)
    fake_page.should_receive(:a_method)
    @world.navigate_to(AnotherPage).class.should == AnotherPage
  end

  it "should pass parameters to methods when navigating" do
    pages = [[FactoryTestPage, :a_method, 'blah'], [AnotherPage, :b_method]]
    PageObject::PageFactory.routes = {:default => pages}
    fake_page = double('a_page')
    FactoryTestPage.should_receive(:new).and_return(fake_page)
    fake_page.should_receive(:a_method).with('blah')
    @world.navigate_to(AnotherPage).class.should == AnotherPage
  end

  it "should fail when it does not find a proper route" do
    PageObject::PageFactory.routes = {:default => ['a'], :another => ['b']}
    expect { @world.navigate_to(AnotherPage, :using => :no_route) }.to raise_error
  end

  it "should fail when no default method specified" do
    PageObject::PageFactory.routes = {
      :default => [[FactoryTestPage, :a_method], [AnotherPage, :b_method]]
    }
    fake_page = double('a_page')
    FactoryTestPage.should_receive(:new).and_return(fake_page)
    fake_page.should_receive(:respond_to?).with(:a_method).and_return(false)
    expect { @world.navigate_to(AnotherPage) }.to raise_error
  end

  it "should know how to continue routing from a location" do
    PageObject::PageFactory.routes = {
      :default => [[FactoryTestPage, :a_method],
                   [AnotherPage, :b_method],
                   [YetAnotherPage, :c_method]]
    }

    @world.current_page = FactoryTestPage.new(@world.browser)
    f_page = FactoryTestPage.new(@world.browser)
    FactoryTestPage.should_receive(:new).and_return(f_page)
    f_page.should_receive(:respond_to?).with(:a_method).and_return(true)
    f_page.should_receive(:a_method)
    a_page = AnotherPage.new(@world.browser)
    AnotherPage.should_receive(:new).and_return(a_page)
    a_page.should_receive(:respond_to?).with(:b_method).and_return(true)
    a_page.should_receive(:b_method)
    @world.continue_navigation_to(YetAnotherPage).class.should == YetAnotherPage
  end
end
