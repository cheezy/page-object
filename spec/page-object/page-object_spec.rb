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
  
  context "when created with a watir-webdriver browser" do
    it "should include the WatirPageObject module" do
      watir_page_object.platform.should be_kind_of PageObject::WatirPageObject
    end
  end

  context "when created with a selenium browser" do
    it "should include the SeleniumPageObject module" do
      selenium_page_object.platform.should be_kind_of Object::PageObject::Platforms::Selenium::PageObject
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
          attr_reader :initialize_page
        
          def initialize_page
            @initialize_page = true
          end
        end
        
        @page = CallbackPage.new(watir_browser)
        @page.initialize_page.should be_true
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

      it "should override alert popup behavior" do
        watir_browser.should_receive(:alert)
        watir_page_object.alert do
        end
      end

      it "should override confirm popup behavior" do
        watir_browser.should_receive(:confirm)
        watir_page_object.confirm(true) do
        end
      end

      it "should override prompt popup behavior" do
        watir_browser.should_receive(:prompt)
        watir_page_object.prompt("blah") do
        end
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

      it "should override alert popup behavior" do
        selenium_browser.should_receive(:execute_script).twice
        selenium_page_object.alert do
        end
      end

      it "should override confirm popup behavior" do
        selenium_browser.should_receive(:execute_script).twice
        selenium_page_object.confirm(true) do
        end
      end
      it "should override prompt popup behavior" do
        selenium_browser.should_receive(:execute_script).twice
        selenium_page_object.prompt("blah") do
        end
      end
      
      it "should switch to a new window with a given title" do
        selenium_browser.should_receive(:window_handles).and_return(["win1"])
        selenium_browser.should_receive(:switch_to).and_return(selenium_browser)
        selenium_browser.should_receive(:window).with("win1").and_return(selenium_browser)
        selenium_browser.should_receive(:title).and_return("My Title")
        selenium_page_object.attach_to_window(:title => "My Title")
      end
      
      it "should switch to a new window with a given url" do
        selenium_browser.should_receive(:window_handles).and_return(["win1"])
        selenium_browser.should_receive(:switch_to).and_return(selenium_browser)
        selenium_browser.should_receive(:window).with("win1").and_return(selenium_browser)
        selenium_browser.should_receive(:current_url).and_return("page.html")
        selenium_page_object.attach_to_window(:url => "page.html")
      end
      
      it "should refresh the page contents" do
        selenium_browser.should_receive(:navigate).and_return(selenium_browser)
        selenium_browser.should_receive(:refresh)
        selenium_page_object.refresh
      end
    end
  end
end
