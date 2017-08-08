require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Media do

  let(:media) { PageObject::Elements::Media.new(double('')) }

  it "should return controls" do
    expect(media).to receive(:attribute).with(:controls).and_return(true)
    expect(media.has_controls?).to eq(true)
  end

end