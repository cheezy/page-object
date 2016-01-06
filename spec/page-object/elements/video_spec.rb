require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::ListItem do

  let(:video) { PageObject::Elements::Video.new(double(''), :platform => :watir_webdriver) }

  it "should return height when present" do
    expect(video).to receive(:attribute).with(:height).and_return("20")
    expect(video.height).to eq(20)
  end

  it "should not return height when not present" do
    expect(video).to receive(:attribute).with(:height).and_return(nil)
    expect(video.height).to eq(nil)
  end

  it "should return width when present" do
    expect(video).to receive(:attribute).with(:width).and_return("20")
    expect(video.width).to eq(20)
  end

  it "should not return width when not present" do
    expect(video).to receive(:attribute).with(:width).and_return(nil)
    expect(video.width).to eq(nil)
  end
end