require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Video do

  let(:video) { PageObject::Elements::Video.new(platform, :platform => :watir_webdriver) }
  let(:platform) { double('platform')}
  let(:wd) { double('wd') }

  before do
    allow(platform).to receive(:wd).and_return wd
  end

  it "should return height when present" do
    expect(wd).to receive(:size).and_return('height' => 20)
    expect(video.height).to eq(20)
  end

  it "should not return height when not present" do
    expect(wd).to receive(:size).and_return({})
    expect(video.height).to eq(nil)
  end

  it "should return width when present" do
    expect(wd).to receive(:size).and_return('width' => 20)
    expect(video.width).to eq(20)
  end

  it "should not return width when not present" do
    expect(wd).to receive(:size).and_return({})
    expect(video.width).to eq(nil)
  end
end