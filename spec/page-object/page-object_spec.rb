require 'spec_helper'

class PageObjectTestPageObject
  include PageObject
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
      selenium_page_object.platform.should be_kind_of PageObject::SeleniumPageObject
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
    end
  end
end
