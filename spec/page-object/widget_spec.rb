require 'spec_helper'
require 'page-object'
require 'page-object/elements'

describe "Widget PageObject Extensions" do
  context "When module is loaded and included before PageObject is loaded " do

    class GxtTable < PageObject::Elements::Table

      @protected

      def child_xpath
        ".//descendant::tr"
      end
    end

    PageObject.register_widget :gxt_table, GxtTable, :div
  end

  class WidgetTestPageObject
    include PageObject

    gxt_table(:a_table, :id => "top_div_id")
    gxt_table :gxt_block_table do |element|
      "block_gxt_table"
    end

    div(:outer_div)
    gxt_table(:a_nested_gxt_table) { |page| page.outer_div_element.gxt_table_element }
  end

  describe "Widget Element Locators" do

    context "when using Watir" do
      let(:watir_browser) { mock_watir_browser }
      let(:watir_page_object) { WidgetTestPageObject.new(watir_browser) }

      it "should find a gxt_table element" do
        watir_browser.should_receive(:div).with(:id => 'blah').and_return(watir_browser)
        element = watir_page_object.gxt_table_element(:id => 'blah')
        element.should be_instance_of GxtTable
      end
    end

    context "when using Selenium" do
      let(:selenium_browser) { mock_selenium_browser }
      let(:selenium_page_object) { WidgetTestPageObject.new(selenium_browser) }

      it "should find a gxt_table element" do
        selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
        element = selenium_page_object.gxt_table_element(:id => 'blah')
        element.should be_instance_of GxtTable
      end
    end
  end

  describe "Widget Accessors" do
    let(:watir_browser) { mock_watir_browser }
    let(:watir_page_object) { WidgetTestPageObject.new(watir_browser) }

    context "using default identifiers" do
      class WatirDefaultIdentifier
        include PageObject

        gxt_table :default_gxt_table
      end

      let(:default_identifier) { WatirDefaultIdentifier.new(watir_browser) }

      def mock_driver_for(tag)
        watir_browser.should_receive(tag).with(:index => 0).and_return(watir_browser)
      end

      it "should work for a gxt_table" do
        mock_driver_for :div
        default_identifier.default_gxt_table_element.should_not be_nil
      end

    end

    describe "gxt_table accessors" do
      context "when called on a page object" do
        it "should generate accessor methods" do
          watir_page_object.should respond_to(:a_table_element)
        end

        it "should call a block on the element method when present" do
          watir_page_object.gxt_block_table_element.should == "block_gxt_table"
        end
      end

      it "should retrieve the table element from the page" do
        watir_browser.should_receive(:div).and_return(watir_browser)
        element = watir_page_object.a_table_element
        element.should be_instance_of GxtTable
      end
    end
  end

  describe "Widget Elements-GxtTable" do
    describe "when mapping how to find an element" do
      it "should map watir types to same" do
        [:class, :id, :index, :xpath].each do |t|
          identifier = GxtTable.watir_identifier_for t => 'value'
          identifier.keys.first.should == t
        end
      end

      it "should map selenium types to same" do
        [:class, :id, :index, :name, :xpath].each do |t|
          key, value = GxtTable.selenium_identifier_for t => 'value'
          key.should == t
        end
      end
    end

    describe "interface" do
      let(:gxt_table_element) { double('gxt_table_element') }

      before(:each) do
        gxt_table_element.stub(:[]).and_return(gxt_table_element)
        gxt_table_element.stub(:find_elements).and_return(gxt_table_element)
      end

      context "for watir" do
        let(:watir_table) { GxtTable.new(gxt_table_element, :platform => :watir_webdriver) }

        it "should return a table row when indexed" do
          gxt_table_element.stub(:[]).with(1).and_return(gxt_table_element)
          watir_table[1].should be_instance_of PageObject::Elements::TableRow
        end

        it "should return the number of rows" do
          gxt_table_element.stub(:wd).and_return(gxt_table_element)
          gxt_table_element.should_receive(:find_elements).with(:xpath, ".//descendant::tr").and_return(gxt_table_element)
          gxt_table_element.should_receive(:size).and_return(2)
          watir_table.rows.should == 2
        end
      end

      context "for selenium" do
        let(:selenium_table) { GxtTable.new(gxt_table_element, :platform => :selenium_webdriver) }

        it "should return a table row when indexed" do
          gxt_table_element.should_receive(:find_elements).with(:xpath, ".//descendant::tr").and_return(gxt_table_element)
          selenium_table[1].should be_instance_of PageObject::Elements::TableRow
        end

        it "should return the number of rows" do
          gxt_table_element.should_receive(:find_elements).with(:xpath, ".//descendant::tr").and_return(gxt_table_element)
          gxt_table_element.should_receive(:size).and_return(2)
          selenium_table.rows.should == 2
        end

        it "should iterate over the table rows" do
          selenium_table.should_receive(:rows).and_return(2)
          count = 0
          selenium_table.each { |e| count += 1 }
          count.should == 2
        end
      end
    end
  end

  describe "Element with nested elements" do
    context "in Watir" do
      before(:each) do
        @watir_driver = Watir::Element.new(nil, {})
        @watir_element = PageObject::Elements::Element.new(@watir_driver, :platform => :watir_webdriver)
      end

      it "should find a nested gxt_table" do
        @watir_driver.should_receive(:div).and_return(@watir_driver)
        @watir_element.gxt_table_element
      end
    end

    context "in Selenium" do
      before(:each) do
        @selenium_driver = double('selenium')
        @selenium_element = PageObject::Elements::Element.new(@selenium_driver, :platform => :selenium_webdriver)
      end

      it "should find a nested gxt_table" do
        @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
        @selenium_element.gxt_table_element
      end
    end
  end
end




