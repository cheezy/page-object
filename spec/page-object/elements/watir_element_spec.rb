require 'spec_helper'
require 'page-object/elements/element'

describe "Element for Watir" do
  let(:watir_driver) { double('watir_driver') }
  let(:watir_element) { ::PageObject::Elements::Element.new(watir_driver, :platform => :watir_webdriver) }

  before(:each) do
    allow(Selenium::WebDriver::Mouse).to receive(:new).and_return(watir_driver)
  end

  it "should know when it is visible" do
    allow(watir_driver).to receive(:present?).and_return(true)
    allow(watir_driver).to receive(:displayed?).and_return(true)
    expect(watir_element.visible?).to eql true
  end

  it "should know when it is not visible" do
    allow(watir_driver).to receive(:present?).and_return(false)
    allow(watir_driver).to receive(:displayed?).and_return(false)
    expect(watir_element.visible?).to eql false
  end

  it "should know when it exists" do
    allow(watir_driver).to receive(:exists?).and_return(true)
    expect(watir_element.exists?).to eql true
  end

  it "should know when it does not exist" do
    allow(watir_driver).to receive(:exists?).and_return(false)
    allow(watir_driver).to receive(:nil?).and_return(true)
    expect(watir_element.exists?).to eql false
  end

  it "should be able to return the text contained in the element" do
    expect(watir_driver).to receive(:text).and_return("my text")
    expect(watir_element.text).to eql "my text"
  end

  it "should know when it is equal to another" do
    expect(watir_driver).to receive(:==).and_return(true)
    expect(watir_element).to eq watir_element
  end

  it "should know when it is not equal to another" do
    expect(watir_element).not_to eq 'not an element'
  end

  it "should return its tag name" do
    expect(watir_driver).to receive(:tag_name).and_return("h1")
    expect(watir_element.tag_name).to eql "h1"
  end

  it "should know its value" do
    allow(watir_driver).to receive(:value).and_return("value")
    allow(watir_driver).to receive(:attribute).and_return("value")
    expect(watir_element.value).to eql "value"
  end

  it "should know how to retrieve the value of an attribute" do
    allow(watir_driver).to receive(:attribute_value).and_return(true)
    allow(watir_driver).to receive(:attribute).and_return(true)
    expect(watir_element.attribute("readonly")).to be true
  end

  it "should be clickable" do
    expect(watir_driver).to receive(:click)
    watir_element.click
  end
  
  it "should be double clickable" do
    expect(watir_driver).to receive(:double_click)
    watir_element.double_click
  end
  
  it "should be right clickable" do
    allow(watir_driver).to receive(:right_click)
    allow(watir_driver).to receive(:context_click)
    watir_element.right_click
  end

  it "should be able to block until it is present" do
    allow(watir_driver).to receive(:wait_until_present).with(10)
    watir_element.when_present(10)
  end
  
  it "should return the element when it is present" do
    allow(watir_driver).to receive(:wait_until_present).with(10)
    element = watir_element.when_present(10)
    expect(element).to equal watir_element
  end

  it "should use the overriden wait when set" do
    PageObject.default_element_wait = 20
    allow(watir_driver).to receive(:wait_until_present).with(20)
    watir_element.when_present
  end

  it "should be able to block until it is visible" do
    allow(::Watir::Wait).to receive(:until).with(10, "Element was not visible in 10 seconds")
    allow(watir_driver).to receive(:displayed?).and_return(true)
    watir_element.when_visible(10)
  end
  
  it "should return the element when it is visible" do
    allow(::Watir::Wait).to receive(:until).with(10, "Element was not visible in 10 seconds")
    allow(watir_driver).to receive(:displayed?).and_return(true)
    element = watir_element.when_visible(10)
    expect(element).to equal watir_element
  end

  it "should be able to block until it is not visible" do
    allow(::Watir::Wait).to receive(:while).with(10, "Element still visible after 10 seconds")
    allow(watir_driver).to receive(:displayed?).and_return(false)
    watir_element.when_not_visible(10)
  end
  
  it "should return the element when it is not visible" do
    allow(::Watir::Wait).to receive(:while).with(10, "Element still visible after 10 seconds")
    allow(watir_driver).to receive(:displayed?).and_return(false)
    element = watir_element.when_not_visible(10)
    expect(element).to equal watir_element
  end

  it "should be able to block until a user define event fires true" do
    allow(::Watir::Wait).to receive(:until).with(10, "Element blah")
    watir_element.wait_until(10, "Element blah") {true}
  end
  
  it "should send keys to the element" do
    expect(watir_driver).to receive(:send_keys).with([:control, 'a'])
    watir_element.send_keys([:control, 'a'])
  end
  
  it "should clear its' contents" do
    expect(watir_driver).to receive(:clear)
    watir_element.clear
  end

  it "should scroll into view" do
    allow(watir_driver).to receive(:wd).and_return(watir_driver)
    expect(watir_driver).to receive(:location_once_scrolled_into_view)
    watir_element.scroll_into_view
  end

  it "should know its location" do
    allow(watir_driver).to receive(:wd).and_return(watir_driver)
    expect(watir_driver).to receive(:location)
    watir_element.location
  end

  it "should know its size" do
    allow(watir_driver).to receive(:wd).and_return(watir_driver)
    expect(watir_driver).to receive(:size)
    watir_element.size
  end

  it "should have a height" do
    allow(watir_driver).to receive(:wd).and_return(watir_driver)
    expect(watir_driver).to receive(:size).and_return({'width' => 30, 'height' => 20})
    expect(watir_element.height).to eql 20
  end

  it "should have a width" do
    allow(watir_driver).to receive(:wd).and_return(watir_driver)
    expect(watir_driver).to receive(:size).and_return({'width' => 30, 'height' => 20})
    expect(watir_element.width).to eql 30
  end

  it "should have a centre" do
    allow(watir_driver).to receive(:wd).and_return(watir_driver)
    expect(watir_driver).to receive(:location).and_return({'y' => 80, 'x' => 40})
    expect(watir_driver).to receive(:size).and_return({'width' => 30, 'height' => 20})
    expect(watir_element.centre).to include(
      'y' => 90,
      'x' => 55
    )
  end

  it "should have a centre greater than y position" do
    allow(watir_driver).to receive(:wd).and_return(watir_driver)
    expect(watir_driver).to receive(:location).and_return({'y' => 80, 'x' => 40}).twice
    expect(watir_driver).to receive(:size).and_return({'width' => 30, 'height' => 20})
    expect(watir_element.centre['y']).to be > watir_element.location['y']
  end

  it "should have a centre greater than x position" do
    allow(watir_driver).to receive(:wd).and_return(watir_driver)
    expect(watir_driver).to receive(:location).and_return({'y' => 80, 'x' => 40}).twice
    expect(watir_driver).to receive(:size).and_return({'width' => 30, 'height' => 20})
    expect(watir_element.centre['x']).to be > watir_element.location['x']
  end
end
