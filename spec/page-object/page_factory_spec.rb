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
    expect(@world.super_called).to be true
  end

  it "should create a new page object and execute a block" do
    expect(@world.browser).not_to receive(:goto)
    @world.on_page FactoryTestPage do |page|
      expect(page).to be_instance_of FactoryTestPage
    end
    @world.on_page "FactoryTestPage" do |page|
      expect(page).to be_instance_of FactoryTestPage
    end
    @world.on_page "ContainingModule::PageInsideModule" do |page|
      expect(page).to be_instance_of ContainingModule::PageInsideModule
    end
  end

  it "should create a new page object and execute a block using 'on'" do
    expect(@world.browser).not_to receive(:goto)
    @world.on FactoryTestPage do |page|
      expect(page).to be_instance_of FactoryTestPage
    end
    @world.on "FactoryTestPage" do |page|
      expect(page).to be_instance_of FactoryTestPage
    end
    @world.on "ContainingModule::PageInsideModule" do |page|
      expect(page).to be_instance_of ContainingModule::PageInsideModule
    end
  end

  it "should create and visit a new page" do
    expect(@world.browser).to receive(:goto).exactly(3).times
    @world.visit_page FactoryTestPage do |page|
      expect(page).to be_instance_of FactoryTestPage
    end
    @world.visit_page "FactoryTestPage" do |page|
      expect(page).to be_instance_of FactoryTestPage
    end
    @world.visit_page "ContainingModule::PageInsideModule" do |page|
      expect(page).to be_instance_of ContainingModule::PageInsideModule
    end
  end

  it "should merge params with the class level params if provided when visiting" do
    expect(@world.browser).to receive(:goto)
    FactoryTestPage.params = {:initial => :value}
    @world.visit_page(FactoryTestPage, :using_params => {:new_value => :merged})
    merged = FactoryTestPage.instance_variable_get("@merged_params")
    expect(merged[:initial]).to eql :value
    expect(merged[:new_value]).to eql :merged
  end

  it "should use the params in the url when they are provided" do
    class PageUsingParams
      include PageObject
      page_url "http://google.com/<%=params[:value]%>"
    end
    expect(@world.browser).to receive(:goto).with("http://google.com/PageObject")
    @world.visit_page(PageUsingParams, :using_params => {:value => 'PageObject'})
  end

  it "should use the params as well as interpolated values" do
    class PageUsingParmsAndInterpolated
      include PageObject
      page_url "http://google.com/#{1+2}/<%=params[:value]%>"
    end
    expect(@world.browser).to receive(:goto).with("http://google.com/3/PageObject")
    @world.visit_page(PageUsingParmsAndInterpolated, :using_params => {:value => 'PageObject'})
  end

  it "should create and visit a new page using 'visit'" do
    expect(@world.browser).to receive(:goto).exactly(3).times
    @world.visit FactoryTestPage do |page|
      expect(page).to be_instance_of FactoryTestPage
    end
    @world.visit "FactoryTestPage" do |page|
      expect(page).to be_instance_of FactoryTestPage
    end
    @world.visit "ContainingModule::PageInsideModule" do |page|
      expect(page).to be_instance_of ContainingModule::PageInsideModule
    end
  end

  it "should create and visit a new page when url is defined as 'direct_url'" do
    expect(@world.browser).to receive(:goto)
    @world.visit TestPageWithDirectUrl do |page|
      expect(page).to be_instance_of TestPageWithDirectUrl
    end
  end
  
  it "should set an instance variable that can be used outside of the block" do
    page = @world.on_page FactoryTestPage
    current_page = @world.instance_variable_get "@current_page"
    expect(current_page).to equal page
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
    expect(@world.if_page(FactoryTestPage)).to eql expected
    expect(@world.if_page("FactoryTestPage")).to eql expected
    expect(@world.if_page("ContainingModule::PageInsideModule")).to eql expected
  end

  it "should execute the block when we ask if it is the correct page" do
    @world.instance_variable_set "@current_page", FactoryTestPage.new(@world.browser)
    
    done = false
    @world.if_page(FactoryTestPage) do |page|
      expect(page).to be_instance_of FactoryTestPage
      done = true 
    end
    expect(done).to be true
    
    done = false
    @world.if_page("FactoryTestPage") do |page|
      expect(page).to be_instance_of FactoryTestPage
      done = true
    end
    expect(done).to be true
    
    done = false
    @world.instance_variable_set "@current_page", ContainingModule::PageInsideModule.new(@world.browser) 
    @world.if_page("ContainingModule::PageInsideModule") do |page|
      expect(page).to be_instance_of ContainingModule::PageInsideModule
      done = true
    end
    expect(done).to be true
  end

  it "should raise an error when you do not provide a default route" do
    expect { PageObject::PageFactory.routes = {:another => []} }.to raise_error "You must provide a :default route"
  end

  it "should store the routes" do
    routes = ['a', 'b', 'c']
    PageObject::PageFactory.routes = {:default => routes}
    expect(PageObject::PageFactory.routes[:default]).to eql routes
  end

  it "should navigate to a page calling the default methods" do
    pages = [[FactoryTestPage, :a_method], [AnotherPage, :b_method]]
    PageObject::PageFactory.routes = {:default => pages}
    fake_page = double('a_page')
    expect(FactoryTestPage).to receive(:new).and_return(fake_page)
    expect(fake_page).to receive(:a_method)
    expect(@world.navigate_to(AnotherPage).class).to eql AnotherPage
  end

  it "should pass parameters to methods when navigating" do
    pages = [[FactoryTestPage, :a_method, 'blah'], [AnotherPage, :b_method]]
    PageObject::PageFactory.routes = {:default => pages}
    fake_page = double('a_page')
    expect(FactoryTestPage).to receive(:new).and_return(fake_page)
    expect(fake_page).to receive(:a_method).with('blah')
    expect(@world.navigate_to(AnotherPage).class).to eql AnotherPage
  end

  it "should fail when it does not find a proper route" do
    PageObject::PageFactory.routes = {:default => ['a'], :another => ['b']}
    expect { @world.navigate_to(AnotherPage, :using => :no_route) }.to raise_error "PageFactory route :no_route not found"
  end

  it "should fail when no default method specified" do
    PageObject::PageFactory.routes = {
      :default => [[FactoryTestPage, :a_method], [AnotherPage, :b_method]]
    }
    fake_page = double('a_page')
    expect(FactoryTestPage).to receive(:new).and_return(fake_page)
    expect(fake_page).to receive(:respond_to?).with(:a_method).and_return(false)
    expect { @world.navigate_to(AnotherPage) }.to raise_error "Navigation method 'a_method' not defined on FactoryTestPage."
  end

end
