require 'page-object/elements'
require 'selenium-webdriver'


describe "Element for Selenium" do
  before(:each) do
    @selenium_driver = double('selenium')
    @selenium_element = ::PageObject::Elements::Element.new(@selenium_driver, :platform => :selenium_webdriver)
  end

  it "should know when it is visible" do
    @selenium_driver.should_receive(:displayed?).and_return(true)
    @selenium_element.visible?.should == true
  end

  it "should know when it is not visible" do
    @selenium_driver.should_receive(:displayed?).and_return(false)
    @selenium_element.visible?.should == false
  end

  it "should know when it exists" do
    @selenium_driver.should_receive(:nil?).and_return(false)
    @selenium_element.exists?.should == true
  end

  it "should know when it does not exist" do
    @selenium_element = ::PageObject::Elements::Element.new(nil, :platform => :selenium_webdriver)
    @selenium_element.exists?.should == false
  end

  it "should flash an element" do
    bridge = double('bridge')
    @selenium_driver.should_receive(:attribute).and_return('blue')
    @selenium_driver.should_receive(:instance_variable_get).and_return(bridge)
    bridge.should_receive(:executeScript).exactly(10).times
    @selenium_element.flash
  end

  it "should be able to return the text contained in the element" do
    @selenium_driver.should_receive(:text).and_return("my text")
    @selenium_element.text.should == "my text"
  end

  it "should know when it is equal to another" do
    @selenium_driver.should_receive(:==).and_return(true)
    @selenium_element.should == @selenium_element
  end

  it "should return its tag name" do
    @selenium_driver.should_receive(:tag_name).and_return("h1")
    @selenium_element.tag_name.should == "h1"
  end

  it "should know its value" do
    @selenium_driver.should_receive(:attribute).with('value').and_return("value")
    @selenium_element.value.should == "value"
  end

  it "should know how to retrieve the value of an attribute" do
    @selenium_driver.should_receive(:attribute).and_return(true)
    @selenium_element.attribute('readonly').should be true
  end

  it "should be clickable" do
    @selenium_driver.should_receive(:click)
    @selenium_element.click
  end

  it "should be double clickable" do
    Selenium::WebDriver::Mouse.should_receive(:new).and_return(@selenium_driver)
    @selenium_driver.should_receive(:double_click)
    @selenium_element.double_click
  end
  
  it "should be right clickable" do
    @selenium_driver.should_receive(:context_click)
    @selenium_element.right_click
  end

  it "should be able to block until it is present" do
    wait = double('wait')
    ::Selenium::WebDriver::Wait.should_receive(:new).and_return(wait)
    wait.should_receive(:until)
    @selenium_element.when_present(10)
  end
  
  it "should return the element when it is present" do
    wait = double('wait')
    ::Selenium::WebDriver::Wait.should_receive(:new).and_return(wait)
    wait.should_receive(:until)
    element = @selenium_element.when_present(10)
    element.should === @selenium_element
  end

  it "should return when an element is not present" do
    wait = double('wait')
    ::Selenium::WebDriver::Wait.should_receive(:new).and_return(wait)
    wait.should_receive(:until)
    @selenium_element.when_not_present
  end

  it "should be able to block until it is visible" do
    wait = double('wait')
    ::Selenium::WebDriver::Wait.should_receive(:new).and_return(wait)
    wait.should_receive(:until)
    @selenium_element.when_visible(10)
  end
  
  it "should return the element when it is visible" do
    wait = double('wait')
    ::Selenium::WebDriver::Wait.should_receive(:new).and_return(wait)
    wait.should_receive(:until)
    element = @selenium_element.when_visible(10)
    element.should === @selenium_element
  end

  it "should be able to block until it is not visible" do
    wait = double('wait')
    ::Selenium::WebDriver::Wait.should_receive(:new).and_return(wait)
    wait.should_receive(:until)
    @selenium_element.when_not_visible(10)
  end

  it "should return the element when it is not visible" do
    wait = double('wait')
    ::Selenium::WebDriver::Wait.should_receive(:new).and_return(wait)
    wait.should_receive(:until)
    element = @selenium_element.when_not_visible(10)
    element.should === @selenium_element
  end

  it "should be able to block until a user define event fires true" do
    wait = double('wait')
    ::Selenium::WebDriver::Wait.should_receive(:new).and_return(wait)
    wait.should_receive(:until)
    @selenium_element.wait_until(10, "Element blah") {}
  end

  it "should send keys to the element" do
    @selenium_driver.should_receive(:send_keys).with([:control, 'a'])
    @selenium_element.send_keys([:control, 'a'])
  end
  
  it "should clear its' contents" do
    @selenium_driver.should_receive(:clear)
    @selenium_element.clear
  end

  it "should fire an event" do
    @selenium_driver.should_receive(:instance_variable_get).with(:@bridge).and_return(@selenium_driver)
    @selenium_driver.should_receive(:executeScript)
    @selenium_element.fire_event('onfocus')
  end

  it "should find the parent element" do
    @selenium_driver.should_receive(:instance_variable_get).with(:@bridge).and_return(@selenium_driver)
    @selenium_driver.should_receive(:executeScript).and_return(@selenium_driver)
    @selenium_driver.should_receive(:tag_name).twice.and_return(:div)
    @selenium_element.parent
  end

  it "should set the focus" do
    @selenium_driver.should_receive(:instance_variable_get).and_return(@selenium_driver)
    @selenium_driver.should_receive(:executeScript)
    @selenium_element.focus
  end

  it "should scroll into view" do
    @selenium_driver.should_receive(:location_once_scrolled_into_view)
    @selenium_element.scroll_into_view
  end
end
