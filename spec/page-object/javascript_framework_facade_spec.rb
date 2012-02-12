require 'spec_helper'

class TestClass
  include PageObject::JavascriptFrameworkFacade
end


describe PageObject::JavascriptFrameworkFacade do
  let(:facade) { PageObject::JavascriptFrameworkFacade }
  
  it "should allow the selection of a javascript framework" do
    facade.framework = :jquery
    facade.framework.should == :jquery
  end

  it "should register the jQuery script builder" do
    facade.framework = :jquery
    facade.script_builder.should == ::PageObject::Javascript::JQuery
  end

  it "should return script for pending requests in jQuery" do
    facade.framework = :jquery
    facade.pending_requests.should == 'return jQuery.active'
  end

  it "should register the Prototype script builder" do
    facade.framework = :prototype
    facade.script_builder.should == ::PageObject::Javascript::Prototype
  end

  it "should return script for pending requests in Prototype" do
    facade.framework = :prototype
    facade.pending_requests.should == 'return Ajax.activeRequestCount'
  end

  it "should not allow you to set the framework to one it does not know about" do
    expect{ facade.framework = :blah }.to raise_error
  end

  it "should allow you to add a new javascript framework" do
    module GoodFake
      def self.pending_requests
        "fake"
      end
    end
    
    facade.add_framework(:blah, GoodFake)
    facade.framework = :blah
    facade.pending_requests.should == "fake"
  end

  it "should not allow you to add a new javascript framework that is invalid" do
    module BadFake
      def self.blah
      end
    end

    expect{ facade.add_framework(:blah, BadFake) }.to raise_error
  end
end

