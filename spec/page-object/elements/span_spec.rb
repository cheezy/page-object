require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Span do
  let(:span) { PageObject::Elements::Span }

  it "should register with tag_name :span" do
    expect(::PageObject::Elements.element_class_for(:span)).to eql ::PageObject::Elements::Span
  end
end
