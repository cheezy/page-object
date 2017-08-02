require 'spec_helper'

class PageObjectTestPageObject
  include PageObject
end

class CustomPlatform
end

describe PageObject do
  let(:watir_browser) { mock_watir_browser }
  let(:watir_page_object) { PageObjectTestPageObject.new(watir_browser) }

  context "setting values on the PageObject module" do
    it "should set the javascript framework" do
      expect(PageObject::JavascriptFrameworkFacade).to receive(:framework=)
      PageObject.javascript_framework = :foo
    end

    it "should add a new Javascript Framework" do
      expect(PageObject::JavascriptFrameworkFacade).to receive(:add_framework)
      PageObject.add_framework(:foo, :bar)
    end

    it "should set a default page wait value" do
      PageObject.default_page_wait = 20
      wait = PageObject.instance_variable_get("@page_wait")
      expect(wait).to eql 20
    end

    it "should provide the default page wait value" do
      PageObject.instance_variable_set("@page_wait", 10)
      expect(PageObject.default_page_wait).to eql 10
    end

    it "should default the page wait value to 30" do
      PageObject.instance_variable_set("@page_wait", nil)
      expect(PageObject.default_page_wait).to eql 30
    end

    it "should set the default element wait value" do
      PageObject.default_element_wait = 20
      wait = PageObject.instance_variable_get("@element_wait")
      expect(wait).to eql 20
    end

    it "should provide the default element wait value" do
      PageObject.instance_variable_set("@element_wait", 10)
      expect(PageObject.default_element_wait).to eql 10
    end

    it "should default the element wait to 5" do
      PageObject.instance_variable_set("@element_wait", nil)
      expect(PageObject.default_element_wait).to eql 5
    end
  end

  context "setting values on the PageObject class instance" do
    it "should set the params value" do
      PageObjectTestPageObject.params = {:some => :value}
      params = PageObjectTestPageObject.instance_variable_get("@params")
      expect(params[:some]).to eql :value
    end

    it "should provide the params value" do
      PageObjectTestPageObject.instance_variable_set("@params", {:value => :updated})
      expect(PageObjectTestPageObject.params[:value]).to eql :updated
    end

    it "should default the params to an empty hash" do
      PageObjectTestPageObject.instance_variable_set("@params", nil)
      expect(PageObjectTestPageObject.params).to eql Hash.new
    end
  end

  context "when created with a watir browser" do
    it "should include the WatirPageObject module" do
      expect(watir_page_object.platform).to be_kind_of PageObject::Platforms::Watir::PageObject
    end
  end

  describe "page level functionality" do
    context "for all drivers" do
      it "should try a second time after sleeping when attach to window fails" do
        expect(watir_page_object.platform).to receive(:attach_to_window).once.and_throw "error"
        expect(watir_page_object.platform).to receive(:attach_to_window)
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
        expect(@page.initialize_page_called).to be true
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
        expect(@page.initialize_accessors_called).to be true
      end

      it "should call initialize_accessors before initialize_page if both exist" do
        class CallbackPage
          include PageObject
          attr_reader :initialize_page, :initialize_accessors

          def initialize_page
            @initialize_accessors = Time.now
          end
        end

        @page = CallbackPage.new(watir_browser)
        expect(@page.initialize_accessors.usec).to be <= @page.initialize_page.usec
      end

      it "should know which element has focus" do
        expect(watir_browser).to receive(:execute_script).and_return(watir_browser)
        expect(watir_browser).to receive(:tag_name).twice.and_return(:input)
        expect(watir_browser).to receive(:type).and_return(:submit)
        expect(watir_page_object.element_with_focus.class).to eql PageObject::Elements::Button
      end

      context "when sent a missing method" do
        it "should respond to it if the @root_element exists and responds" do
          # sanity checks
          expect(watir_page_object).not_to respond_to :bar
          expect(watir_page_object).not_to respond_to :baz
          # set @root_element
          class Foo; def bar; :bar_called; end; private; def baz; end; end
          watir_page_object.instance_variable_set(:@root_element, Foo.new)
          # test
          expect(watir_page_object).to respond_to :bar
          expect(watir_page_object).not_to respond_to :baz
          expect(watir_page_object.bar).to eq :bar_called
        end
      end
    end

    context "when using WatirPageObject" do
      it "should display the page text" do
        expect(watir_browser).to receive(:text).and_return("browser text")
        expect(watir_page_object.text).to eql "browser text"
      end

      it "should display the html of the page" do
        expect(watir_browser).to receive(:html).and_return("<html>Some Sample HTML</html>")
        expect(watir_page_object.html).to eql "<html>Some Sample HTML</html>"
      end

      it "should display the title of the page" do
        expect(watir_browser).to receive(:title).and_return("I am the title of a page")
        expect(watir_page_object.title).to eql "I am the title of a page"
      end

      it "should be able to navigate to a page" do
        expect(watir_browser).to receive(:goto).with("cheezyworld.com")
        watir_page_object.navigate_to("cheezyworld.com")
      end

      it "should wait until a block returns true" do
        expect(watir_browser).to receive(:wait_until).with(timeout: 5, message: "too long")
        watir_page_object.wait_until(5, "too long")
      end

      it "should use the overriden timeout value when set" do
        PageObject.default_page_wait = 10
        expect(watir_browser).to receive(:wait_until).with(timeout: 10, message: nil)
        watir_page_object.wait_until
      end

      it "should wait until there are no pending ajax requests" do
        expect(PageObject::JavascriptFrameworkFacade).to receive(:pending_requests).and_return('pending requests')
        expect(watir_browser).to receive(:execute_script).with('pending requests').and_return(0)
        watir_page_object.wait_for_ajax
      end

      it "should override alert popup behavior" do
        expect(watir_browser).to receive(:alert).exactly(3).times.and_return(watir_browser)
        expect(watir_browser).to receive(:exists?).and_return(true)
        expect(watir_browser).to receive(:text)
        expect(watir_browser).to receive(:ok)
        watir_page_object.alert do
        end
      end

      it "should override confirm popup behavior" do
        expect(watir_browser).to receive(:alert).exactly(3).times.and_return(watir_browser)
        expect(watir_browser).to receive(:exists?).and_return(true)
        expect(watir_browser).to receive(:text)
        expect(watir_browser).to receive(:ok)
        watir_page_object.confirm(true) do
        end
      end

      it "should override prompt popup behavior" do
        expect(watir_browser).to receive(:wd).twice.and_return(watir_browser)
        expect(watir_browser).to receive(:execute_script).twice
        watir_page_object.prompt("blah") do
        end
      end

      it "should execute javascript on the browser" do
        expect(watir_browser).to receive(:execute_script).and_return("abc")
        expect(watir_page_object.execute_script("333")).to eql "abc"
      end

      it "should convert a modal popup to a window" do
        expect(watir_browser).to receive(:execute_script)
        watir_page_object.modal_dialog {}
      end

      it "should switch to a new window with a given title" do
        expect(watir_browser).to receive(:window).with(:title => /My\ Title/).and_return(watir_browser)
        expect(watir_browser).to receive(:use)
        watir_page_object.attach_to_window(:title => "My Title")
      end

      it "should switch to a new window with a given url" do
        expect(watir_browser).to receive(:window).with(:url => /success\.html/).and_return(watir_browser)
        expect(watir_browser).to receive(:use)
        watir_page_object.attach_to_window(:url => "success.html")
      end

      it "should refresh the page contents" do
        expect(watir_browser).to receive(:refresh)
        watir_page_object.refresh
      end

      it "should know how to go back" do
        expect(watir_browser).to receive(:back)
        watir_page_object.back
      end

      it "should know how to go forward" do
        expect(watir_browser).to receive(:forward)
        watir_page_object.forward
      end

      it "should know its' current url" do
        expect(watir_browser).to receive(:url).and_return("cheezyworld.com")
        expect(watir_page_object.current_url).to eql "cheezyworld.com"
      end

      it "should know how to clear all of the cookies from the browser" do
        expect(watir_browser).to receive(:cookies).and_return(watir_browser)
        expect(watir_browser).to receive(:clear)
        watir_page_object.clear_cookies
      end

      it "should be able to save a screenshot" do
        expect(watir_browser).to receive(:wd).and_return(watir_browser)
        expect(watir_browser).to receive(:save_screenshot)
        watir_page_object.save_screenshot("test.png")
      end
    end

  end
end
