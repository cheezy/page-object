require 'spec_helper'
require 'page-object/javascript/jquery'

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
end

