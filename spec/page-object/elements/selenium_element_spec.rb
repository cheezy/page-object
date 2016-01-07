require 'spec_helper'
require 'page-object/elements'
require 'selenium-webdriver'


describe "Element for Selenium" do
  before(:each) do
    @selenium_driver = double('selenium')
    @selenium_element = ::PageObject::Elements::Element.new(@selenium_driver, :platform => :selenium_webdriver)
  end

  it "should know when it is visible" do
    expect(@selenium_driver).to receive(:displayed?).and_return(true)
    expect(@selenium_element.visible?).to be true
  end

  it "should know when it is not visible" do
    expect(@selenium_driver).to receive(:displayed?).and_return(false)
    expect(@selenium_element.visible?).to eql false
  end

  it "should know when it exists" do
    expect(@selenium_driver).to receive(:nil?).and_return(false)
    expect(@selenium_element.exists?).to eql true
  end

  it "should know when it does not exist" do
    @selenium_element = ::PageObject::Elements::Element.new(nil, :platform => :selenium_webdriver)
    expect(@selenium_element.exists?).to eql false
  end

  it "should flash an element" do
    bridge = double('bridge')
    expect(@selenium_driver).to receive(:attribute).and_return('blue')
    expect(@selenium_driver).to receive(:instance_variable_get).and_return(bridge)
    expect(bridge).to receive(:executeScript).exactly(10).times
    @selenium_element.flash
  end

  it "should be able to return the text contained in the element" do
    expect(@selenium_driver).to receive(:text).and_return("my text")
    expect(@selenium_element.text).to eql "my text"
  end

  it "should know when it is equal to another" do
    expect(@selenium_driver).to receive(:==).and_return(true)
    expect(@selenium_element).to eq @selenium_element
  end

  it "should know when it is not equal to another" do
    expect(@selenium_element).not_to eq 'not an element'
  end

  it "should return its tag name" do
    expect(@selenium_driver).to receive(:tag_name).and_return("h1")
    expect(@selenium_element.tag_name).to eql "h1"
  end

  it "should know its value" do
    expect(@selenium_driver).to receive(:attribute).with('value').and_return("value")
    expect(@selenium_element.value).to eql "value"
  end

  it "should know how to retrieve the value of an attribute" do
    expect(@selenium_driver).to receive(:attribute).and_return(true)
    expect(@selenium_element.attribute('readonly')).to be true
  end

  it "should be clickable" do
    expect(@selenium_driver).to receive(:click)
    @selenium_element.click
  end

  it "should be double clickable" do
    expect(Selenium::WebDriver::Mouse).to receive(:new).and_return(@selenium_driver)
    expect(@selenium_driver).to receive(:double_click)
    @selenium_element.double_click
  end
  
  it "should be right clickable" do
    expect(@selenium_driver).to receive(:context_click)
    @selenium_element.right_click
  end

  it "should be able to block until it is present" do
    wait = double('wait')
    expect(::Selenium::WebDriver::Wait).to receive(:new).and_return(wait)
    expect(wait).to receive(:until)
    @selenium_element.when_present(10)
  end
  
  it "should return the element when it is present" do
    wait = double('wait')
    expect(::Selenium::WebDriver::Wait).to receive(:new).and_return(wait)
    expect(wait).to receive(:until)
    element = @selenium_element.when_present(10)
    expect(element).to equal @selenium_element
  end

  it "should return when an element is not present" do
    wait = double('wait')
    expect(::Selenium::WebDriver::Wait).to receive(:new).and_return(wait)
    expect(wait).to receive(:until)
    @selenium_element.when_not_present
  end

  it "should be able to block until it is visible" do
    wait = double('wait')
    expect(::Selenium::WebDriver::Wait).to receive(:new).and_return(wait)
    expect(wait).to receive(:until)
    @selenium_element.when_visible(10)
  end
  
  it "should return the element when it is visible" do
    wait = double('wait')
    expect(::Selenium::WebDriver::Wait).to receive(:new).and_return(wait)
    expect(wait).to receive(:until)
    element = @selenium_element.when_visible(10)
    expect(element).to equal @selenium_element
  end

  it "should be able to block until it is not visible" do
    wait = double('wait')
    expect(::Selenium::WebDriver::Wait).to receive(:new).and_return(wait)
    expect(wait).to receive(:until)
    @selenium_element.when_not_visible(10)
  end

  it "should return the element when it is not visible" do
    wait = double('wait')
    expect(::Selenium::WebDriver::Wait).to receive(:new).and_return(wait)
    expect(wait).to receive(:until)
    element = @selenium_element.when_not_visible(10)
    expect(element).to equal @selenium_element
  end

  it "should be able to block until a user define event fires true" do
    wait = double('wait')
    expect(::Selenium::WebDriver::Wait).to receive(:new).and_return(wait)
    expect(wait).to receive(:until)
    @selenium_element.wait_until(10, "Element blah") {}
  end

  it "should send keys to the element" do
    expect(@selenium_driver).to receive(:send_keys).with([:control, 'a'])
    @selenium_element.send_keys([:control, 'a'])
  end
  
  it "should clear its' contents" do
    expect(@selenium_driver).to receive(:clear)
    @selenium_element.clear
  end

  it "should fire an event" do
    expect(@selenium_driver).to receive(:instance_variable_get).with(:@bridge).and_return(@selenium_driver)
    expect(@selenium_driver).to receive(:executeScript)
    @selenium_element.fire_event('onfocus')
  end

  it "should find the parent element" do
    expect(@selenium_driver).to receive(:instance_variable_get).with(:@bridge).and_return(@selenium_driver)
    expect(@selenium_driver).to receive(:executeScript).and_return(@selenium_driver)
    expect(@selenium_driver).to receive(:tag_name).twice.and_return(:div)
    @selenium_element.parent
  end

  it "should set the focus" do
    expect(@selenium_driver).to receive(:instance_variable_get).and_return(@selenium_driver)
    expect(@selenium_driver).to receive(:executeScript)
    @selenium_element.focus
  end

  it "should scroll into view" do
    expect(@selenium_driver).to receive(:location_once_scrolled_into_view)
    @selenium_element.scroll_into_view
  end

  it "should have a location" do
    expect(@selenium_driver).to receive(:location)
    @selenium_element.location
  end

  it "should have a size" do
    expect(@selenium_driver).to receive(:size)
    @selenium_element.size
  end

  it "should have a height" do
    expect(@selenium_driver).to receive(:size).and_return({'width' => 30, 'height' => 20})
    expect(@selenium_element.height).to eql 20
  end

  it "should have a width" do
    expect(@selenium_driver).to receive(:size).and_return({'width' => 30, 'height' => 20})
    expect(@selenium_element.width).to eql 30
  end

  it "should have a centre" do
    expect(@selenium_driver).to receive(:location).and_return({'y' => 80, 'x' => 40})
    expect(@selenium_driver).to receive(:size).and_return({'width' => 30, 'height' => 20})
    expect(@selenium_element.centre).to include(
      'y' => 90,
      'x' => 55
    )
  end

  it "should have a centre greater than y position" do
    expect(@selenium_driver).to receive(:location).and_return({'y' => 80, 'x' => 40}).twice
    expect(@selenium_driver).to receive(:size).and_return({'width' => 30, 'height' => 20})
    expect(@selenium_element.centre['y']).to be > @selenium_element.location['y']
  end

  it "should have a centre greater than x position" do
    expect(@selenium_driver).to receive(:location).and_return({'y' => 80, 'x' => 40}).twice
    expect(@selenium_driver).to receive(:size).and_return({'width' => 30, 'height' => 20})
    expect(@selenium_element.centre['x']).to be > @selenium_element.location['x']
  end
end
