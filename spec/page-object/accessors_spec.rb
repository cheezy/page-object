require 'spec_helper'

class TestPageObject
  include PageObject

  link(:google_search, {:link => 'Google Search'})
  text_field(:first_name, {:id => 'first_name'})
  select_list(:state, {:id => 'state'})
  checkbox(:active, {:id => 'is_active_id'})
  button(:click_me, { :id => 'button_submit'})
end

describe PageObject::Accessors do
  
  describe "link accessors" do
    let(:watir_browser) { mock_watir_browser }
    let(:selenium_browser) { mock_selenium_browser }
    let(:watir_page_object) { TestPageObject.new(watir_browser) }
    let(:selenium_page_object) { TestPageObject.new(selenium_browser) }

    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:google_search)
      end
    end

    context "Watir implementation" do
      it "should select a link" do
        watir_browser.stub_chain(:link, :click)
        watir_page_object.google_search
      end
    end

    context "Selenium implementation" do
      it "should select a link" do
        selenium_browser.stub_chain(:find_element, :click)
        selenium_page_object.google_search
      end
    end
  end


  describe "text_field accessors" do
    let(:watir_browser) { mock_watir_browser }
    let(:selenium_browser) { mock_selenium_browser }
    let(:watir_page_object) { TestPageObject.new(watir_browser) }
    let(:selenium_page_object) { TestPageObject.new(selenium_browser) }

    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:first_name)
        watir_page_object.should respond_to(:first_name=)
      end
    end

    context "Watir implementation" do
      it "should get the text from the text field element" do
        watir_browser.stub_chain(:text_field, :value).and_return('Kim')
        watir_page_object.first_name.should == 'Kim'
      end
    
      it "should set some text on a text field element" do
        watir_browser.stub_chain(:text_field, :set).with('Kim')
        watir_page_object.first_name = 'Kim'
      end
    end

    context "Selenium implementation" do
      it "should get the text from the text field element" do
        selenium_browser.stub_chain(:find_element, :value).and_return('Katie')
        selenium_page_object.first_name.should == 'Katie'
      end

      it "should set some text on a text field element" do
        selenium_browser.stub_chain(:find_element, :send_keys)
        selenium_page_object.first_name = 'Katie'
      end
    end
  end
  
  
  describe "select_list accessors" do
    let(:watir_browser) { mock_watir_browser }
    let(:selenium_browser) { mock_selenium_browser }
    let(:watir_page_object) { TestPageObject.new(watir_browser) }
    let(:selenium_page_object) { TestPageObject.new(selenium_browser) }
  
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to :state
        watir_page_object.should respond_to :state=
      end
    end
  
    context "Watir implementation" do
      it "should get the current item from a select list" do
        watir_browser.stub_chain(:select_list, :value).and_return("OH")
        watir_page_object.state.should == "OH"
      end
    
      it "should set the current item of a select list" do
        watir_browser.stub(:select_list).and_return watir_browser
        watir_browser.stub(:select).with("OH")
        watir_page_object.state = "OH"
      end
    end
  
    context "Selenium implementation" do
      it "should should get the current item from a select list" do
        selenium_browser.stub_chain(:find_element, :attribute).and_return("OH")
        selenium_page_object.state.should == "OH"
      end
    
      it "should set the current item of a select list" do
        selenium_browser.stub_chain(:find_element, :send_keys).with("OH")
        selenium_page_object.state = "OH"
      end
    end
  end

  
  describe "check_box accessors" do
    let(:watir_browser) { mock_watir_browser }
    let(:selenium_browser) { mock_selenium_browser }
    let(:watir_page_object) { TestPageObject.new(watir_browser) }
    let(:selenium_page_object) { TestPageObject.new(selenium_browser) }

    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to :check_active
        watir_page_object.should respond_to :uncheck_active
        watir_page_object.should respond_to :active_checked?
      end
    end

    context "Watir implementation" do
      it "should check a check box element" do
        watir_browser.should_receive(:checkbox).and_return(watir_browser)
        watir_browser.should_receive(:set)
        watir_page_object.check_active
      end

      it "should clear a check box element" do
        watir_browser.should_receive(:checkbox).and_return(watir_browser)
        watir_browser.should_receive(:clear)
        watir_page_object.uncheck_active
      end

      it "should know if a check box element is selected" do
        watir_browser.should_receive(:checkbox).and_return(watir_browser)
        watir_browser.should_receive(:set?).and_return(true)
        watir_page_object.active_checked?.should be_true
      end
    end

    context "Selenium implementation" do
      it "should check a check box element" do
        selenium_browser.should_receive(:find_element).twice.and_return(selenium_browser)
        selenium_browser.should_receive(:selected?).and_return(false)
        selenium_browser.should_receive(:toggle)
        selenium_page_object.check_active
      end
    
      it "should clear a check box element" do
        selenium_browser.should_receive(:find_element).twice.and_return(selenium_browser)
        selenium_browser.should_receive(:selected?).and_return(true)
        selenium_browser.should_receive(:toggle)
        selenium_page_object.uncheck_active
      end
    
      it "should know if a check box element is selected" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:selected?).and_return(true)
        selenium_page_object.active_checked?.should be_true
      end
    end
  end

    describe "button accessors" do
      let(:watir_browser) { mock_watir_browser }
      let(:selenium_browser) { mock_selenium_browser }
      let(:watir_page_object) { TestPageObject.new(watir_browser) }
      let(:selenium_page_object) { TestPageObject.new(selenium_browser) }

    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to :click_me
      end
    end
      
    end

end
