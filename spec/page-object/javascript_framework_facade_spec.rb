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

  it "should register the Dojo script builder" do
    facade.framework = :dojo
    facade.script_builder.should == ::PageObject::Javascript::Dojo
  end

  it "should return script for pending requests in Dojo" do
    facade.framework = :dojo
    facade.pending_requests.should == 'return dojo.io.XMLHTTPTransport.inFlight.length'
  end
end

