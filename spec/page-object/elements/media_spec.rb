require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Media do

  let(:media) { PageObject::Elements::Media.new(double(''), :platform => :watir_webdriver) }

  it "should return autoplay" do
    expect(media).to receive(:attribute).with(:autoplay).and_return(true)
    expect(media.autoplay?).to eq(true)
  end

  it "should return controls" do
    expect(media).to receive(:attribute).with(:controls).and_return(true)
    expect(media.has_controls?).to eq(true)
  end

  it "should return paused" do
    expect(media).to receive(:attribute).with(:paused).and_return(true)
    expect(media.paused?).to eq(true)
  end

  it "should not return duration when not present" do
    expect(media).to receive(:attribute).with(:duration).and_return(nil)
    expect(media.duration).to eq(nil)
  end

  it "should return duration when present" do
    expect(media).to receive(:attribute).with(:duration).and_return('1.405')
    expect(media.duration).to eq(1.405)
  end

  it "should not return volume when not present" do
    expect(media).to receive(:attribute).with(:volume).and_return(nil)
    expect(media.volume).to eq(nil)
  end

  it "should return volume when present" do
    expect(media).to receive(:attribute).with(:volume).and_return('3')
    expect(media.volume).to eq(3)
  end

  it "should return ended" do
    expect(media).to receive(:attribute).with(:ended).and_return(true)
    expect(media.ended?).to eq(true)
  end

  it "should return seeking" do
    expect(media).to receive(:attribute).with(:seeking).and_return(true)
    expect(media.seeking?).to eq(true)
  end

  it "should return loop" do
    expect(media).to receive(:attribute).with(:loop).and_return(true)
    expect(media.loop?).to eq(true)
  end

  it "should return muted" do
    expect(media).to receive(:attribute).with(:muted).and_return(true)
    expect(media.muted?).to eq(true)
  end

end