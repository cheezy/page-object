require 'spec_helper'

class PageObjectTestPageObject
  include PageObject
end

class CustomPlatform
end

describe PageObject do
  let(:watir_browser) { mock_watir_browser }
  let(:selenium_browser) { mock_selenium_browser }
  let(:watir_page_object) { PageObjectTestPageObject.new(watir_browser) }
  let(:selenium_page_object) { PageObjectTestPageObject.new(selenium_browser) }

  context "setting values on the PageObject module" do
    it "should set the javascript framework" do
      PageObject::JavascriptFrameworkFacade.should_receive(:framework=)
      PageObject.javascript_framework = :foo
    end

    it "should add a new Javascript Framework" do
      PageObject::JavascriptFrameworkFacade.should_receive(:add_framework)
      PageObject.add_framework(:foo, :bar)
    end

    it "should set a default page wait value" do
      PageObject.default_page_wait = 20
      wait = PageObject.instance_variable_get("@page_wait")
      wait.should == 20
    end

    it "should provide the default page wait value" do
      PageObject.instance_variable_set("@page_wait", 10)
      PageObject.default_page_wait.should == 10
    end

    it "should default the page wait value to 30" do
      PageObject.instance_variable_set("@page_wait", nil)
      PageObject.default_page_wait.should == 30
    end

    it "should set the default element wait value" do
      PageObject.default_element_wait = 20
      wait = PageObject.instance_variable_get("@element_wait")
      wait.should == 20
    end

    it "should provide the default element wait value" do
      PageObject.instance_variable_set("@element_wait", 10)
      PageObject.default_element_wait.should == 10
    end

    it "should default the element wait to 5" do
      PageObject.instance_variable_set("@element_wait", nil)
      PageObject.default_element_wait.should == 5
    end
  end

  context "setting values on the PageObject class instance" do
    it "should set the params value" do
      PageObjectTestPageObject.params = {:some => :value}
      params = PageObjectTestPageObject.instance_variable_get("@params")
      params[:some].should == :value
    end

    it "should provide the params value" do
      PageObjectTestPageObject.instance_variable_set("@params", {:value => :updated})
      PageObjectTestPageObject.params[:value].should == :updated
    end

    it "should default the params to an empty hash" do
      PageObjectTestPageObject.instance_variable_set("@params", nil)
      PageObjectTestPageObject.params.should == {}
    end
  end

  context "when created with a watir-webdriver browser" do
    it "should include the WatirPageObject module" do
      watir_page_object.platform.should be_kind_of PageObject::Platforms::WatirWebDriver::PageObject
    end
  end

  context "when created with a selenium browser" do
    it "should include the SeleniumPageObject module" do
      selenium_page_object.platform.should be_kind_of PageObject::Platforms::SeleniumWebDriver::PageObject
    end
  end
  
  context "when created with a non_bundled adapter" do
    let(:custom_adapter) { mock_adapter(:custom_browser, CustomPlatform) }
    it "should be an instance of whatever that objects adapter is" do
      mock_adapters({:custom_adapter=>custom_adapter})
      custom_page_object = PageObjectTestPageObject.new(:custom_browser)
      custom_page_object.platform.should be custom_adapter.create_page_object
    end
  end
  
  context "when created with an object we do not understand" do
    it "should throw an error" do
      expect {
        TestPageObject.new("blah")
      }.to raise_error
    end
  end

  describe "page level functionality" do
    context "for all drivers" do
      it "should try a second time after sleeping when attach to window fails" do
        watir_page_object.platform.should_receive(:attach_to_window).once.and_throw "error"
        watir_page_object.platform.should_receive(:attach_to_window)
        watir_page_object.attach_to_window("blah")
      end
      
      it "should call initialize_page if it exists" do
        class CallbackPage
          include PageObject
          attr_reader :initialize_page_called
        
          def initialize_page
            @initialize_page_called = true
          end
        end
        
        @page = CallbackPage.new(watir_browser)
        @page.initialize_page_called.should be true
      end

      it "should call initialize_accessors if it exists" do
        class CallbackPage
          include PageObject
          attr_reader :initialize_accessors_called

          def initialize_accessors
            @initialize_accessors_called = true
          end
        end

        @page = CallbackPage.new(watir_browser)
        @page.initialize_accessors_called.should be true
      end

      it "should call initialize_accessors before initialize_page if both exist" do
        class CallbackPage
          include PageObject
          attr_reader :initialize_page, :initialize_accessors

          def initialize_page
            @initialize_accessors = Time.now
          end

          def initialize_page
            @initialize_accessors = Time.now
          end
        end

        @page = CallbackPage.new(watir_browser)
        @page.initialize_accessors.usec.should be <= @page.initialize_page.usec
      end

      it "should know which element has focus" do
        watir_browser.should_receive(:execute_script).and_return(watir_browser)
        watir_browser.should_receive(:tag_name).twice.and_return(:input)
        watir_browser.should_receive(:type).and_return(:submit)
        watir_page_object.element_with_focus.class.should == PageObject::Elements::Button
      end
    end
    
    context "when using WatirPageObject" do
      it "should display the page text" do
        watir_browser.should_receive(:text).and_return("browser text")
        watir_page_object.text.should == "browser text"
      end

      it "should display the html of the page" do
        watir_browser.should_receive(:html).and_return("<html>Some Sample HTML</html>")
        watir_page_object.html.should == "<html>Some Sample HTML</html>"
      end

      it "should display the title of the page" do
        watir_browser.should_receive(:title).and_return("I am the title of a page")
        watir_page_object.title.should == "I am the title of a page"
      end

      it "should be able to navigate to a page" do
        watir_browser.should_receive(:goto).with("cheezyworld.com")
        watir_page_object.navigate_to("cheezyworld.com")
      end

      it "should wait until a block returns true" do
        watir_browser.should_receive(:wait_until).with(5, "too long")
        watir_page_object.wait_until(5, "too long")
      end

      it "should use the overriden timeout value when set" do
        PageObject.default_page_wait = 10
        watir_browser.should_receive(:wait_until).with(10, nil)
        watir_page_object.wait_until
      end

      it "should wait until there are no pending ajax requests" do
        PageObject::JavascriptFrameworkFacade.should_receive(:pending_requests).and_return('pending requests')
        watir_browser.should_receive(:execute_script).with('pending requests').and_return(0)
        watir_page_object.wait_for_ajax
      end

      it "should override alert popup behavior" do
        watir_browser.should_receive(:alert).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:exists?).and_return(true)
        watir_browser.should_receive(:text)
        watir_browser.should_receive(:ok)
        watir_page_object.alert do
        end
      end

      it "should override confirm popup behavior" do
        watir_browser.should_receive(:alert).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:exists?).and_return(true)
        watir_browser.should_receive(:text)
        watir_browser.should_receive(:ok)
        watir_page_object.confirm(true) do
        end
      end

      it "should override prompt popup behavior" do
        watir_browser.should_receive(:wd).twice.and_return(watir_browser)
        watir_browser.should_receive(:execute_script).twice
        watir_page_object.prompt("blah") do
        end
      end

      it "should execute javascript on the browser" do
        watir_browser.should_receive(:execute_script).and_return("abc")
        watir_page_object.execute_script("333").should == "abc"
      end
      
      it "should convert a modal popup to a window" do
        watir_browser.should_receive(:execute_script)
        watir_page_object.modal_dialog {}
      end
      
      it "should switch to a new window with a given title" do
        watir_browser.should_receive(:window).with(:title => /My\ Title/).and_return(watir_browser)
        watir_browser.should_receive(:use)
        watir_page_object.attach_to_window(:title => "My Title")
      end
      
      it "should switch to a new window with a given url" do
        watir_browser.should_receive(:window).with(:url => /success\.html/).and_return(watir_browser)
        watir_browser.should_receive(:use)
        watir_page_object.attach_to_window(:url => "success.html")
      end
      
      it "should refresh the page contents" do
        watir_browser.should_receive(:refresh)
        watir_page_object.refresh
      end

      it "should know how to go back" do
        watir_browser.should_receive(:back)
        watir_page_object.back
      end

      it "should know how to go forward" do
        watir_browser.should_receive(:forward)
        watir_page_object.forward
      end
      
      it "should know its' current url" do
        watir_browser.should_receive(:url).and_return("cheezyworld.com")
        watir_page_object.current_url.should == "cheezyworld.com"
      end
      
      it "should know how to clear all of the cookies from the browser" do
        watir_browser.should_receive(:cookies).and_return(watir_browser)
        watir_browser.should_receive(:clear)
        watir_page_object.clear_cookies
      end
      
      it "should be able to save a screenshot" do
        watir_browser.should_receive(:wd).and_return(watir_browser)
        watir_browser.should_receive(:save_screenshot)
        watir_page_object.save_screenshot("test.png")
      end
    end

    context "when using SeleniumPageObject" do
      it "should display the page text" do
        selenium_browser.stub_chain(:find_element, :text).and_return("browser text")
        selenium_page_object.text.should == "browser text"
      end

      it "should display the html of the page" do
        selenium_browser.should_receive(:page_source).and_return("<html>Some Sample HTML</html>")
        selenium_page_object.html.should == "<html>Some Sample HTML</html>"
      end

      it "should display the title of the page" do
        selenium_browser.should_receive(:title).and_return("I am the title of a page")
        selenium_page_object.title.should == "I am the title of a page"
      end

      it "should be able to navigate to a page" do
        selenium_browser.stub_chain(:navigate, :to).with('cheezyworld.com')
        selenium_page_object.navigate_to('cheezyworld.com')
      end

      it "should wait until a block returns true" do
        wait = double('wait')
        Selenium::WebDriver::Wait.should_receive(:new).with({:timeout => 5, :message => 'too long'}).and_return(wait)
        wait.should_receive(:until)
        selenium_page_object.wait_until(5, 'too long')
      end

      it "should wait until there are no pending ajax requests" do
        PageObject::JavascriptFrameworkFacade.should_receive(:pending_requests).and_return('pending requests')
        selenium_browser.should_receive(:execute_script).with('pending requests').and_return(0)
        selenium_page_object.wait_for_ajax
      end

      it "should override alert popup behavior" do
        selenium_browser.should_receive(:switch_to).and_return(selenium_browser)
        selenium_browser.should_receive(:alert).and_return(selenium_browser)
        selenium_browser.should_receive(:text)
        selenium_browser.should_receive(:accept)
        selenium_page_object.alert do
        end
      end

      it "should override confirm popup behavior" do
        selenium_browser.should_receive(:switch_to).and_return(selenium_browser)
        selenium_browser.should_receive(:alert).and_return(selenium_browser)
        selenium_browser.should_receive(:text)
        selenium_browser.should_receive(:accept)
        selenium_page_object.confirm(true) do
        end
      end
      it "should override prompt popup behavior" do
        selenium_browser.should_receive(:execute_script).twice
        selenium_page_object.prompt("blah") do
        end
      end
      
      it "should convert a modal popup to a window" do
        selenium_browser.should_receive(:execute_script)
        selenium_page_object.modal_dialog {}
      end
      
      it "should execute javascript on the browser" do
        selenium_browser.should_receive(:execute_script).and_return("abc")
        selenium_page_object.execute_script("333").should == "abc"
      end

      it "should switch to a new window with a given title" do
        selenium_browser.should_receive(:window_handles).and_return(["win1"])
        selenium_browser.should_receive(:switch_to).twice.and_return(selenium_browser)
        selenium_browser.should_receive(:window).twice.with("win1").and_return(selenium_browser)
        selenium_browser.should_receive(:title).and_return("My Title")
        selenium_page_object.attach_to_window(:title => "My Title")
      end
      
      it "should switch to a new window with a given url" do
        selenium_browser.should_receive(:window_handles).and_return(["win1"])
        selenium_browser.should_receive(:switch_to).twice.and_return(selenium_browser)
        selenium_browser.should_receive(:window).twice.with("win1").and_return(selenium_browser)
        selenium_browser.should_receive(:current_url).and_return("page.html")
        selenium_page_object.attach_to_window(:url => "page.html")
      end
      
      it "should refresh the page contents" do
        selenium_browser.should_receive(:navigate).and_return(selenium_browser)
        selenium_browser.should_receive(:refresh)
        selenium_page_object.refresh
      end
      
      it "should know how to go back" do
        selenium_browser.should_receive(:navigate).and_return(selenium_browser)
        selenium_browser.should_receive(:back)
        selenium_page_object.back
      end
      
      it "should know how to go forward" do
        selenium_browser.should_receive(:navigate).and_return(selenium_browser)
        selenium_browser.should_receive(:forward)
        selenium_page_object.forward
      end
      
      it "should know its' current url" do
        selenium_browser.should_receive(:current_url).and_return("cheezyworld.com")
        selenium_page_object.current_url.should == "cheezyworld.com"
      end
      
      it "should clear all of the cookies from the browser" do
        selenium_browser.should_receive(:manage).and_return(selenium_browser)
        selenium_browser.should_receive(:delete_all_cookies)
        selenium_page_object.clear_cookies
      end
      
      it "should be able to save a screenshot" do
        selenium_browser.should_receive(:save_screenshot)
        selenium_page_object.save_screenshot("test.png")
      end
    end
  end
end
