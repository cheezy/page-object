require 'spec_helper'
require 'page-object'
require 'page-object/elements'

describe "Widget PageObject Extensions" do
  context "When module is loaded and included before PageObject is loaded " do

    class GxtTable < PageObject::Elements::Table

      @protected

      def strategy
        :descendant
      end
    end
    PageObject.register_widget :gxt_table, GxtTable, :div

    class WidgetMatrix < PageObject::Elements::Table
      def self.plural_form
        'widget_matrices'
      end
    end
    PageObject.register_widget :widget_matrix, WidgetMatrix, :div
  end

  class WidgetTestPageObject
    include PageObject

    gxt_table(:a_table, :id => "top_div_id")
    gxt_tables(:some_table, :class => "top_div_class")
    gxt_table :gxt_block_table do |element|
      "block_gxt_table"
    end
    gxt_tables :gxt_multiple_block_table do |element|
      "multiple_block_gxt_table"
    end

    widget_matrices :matrix, :class => 'matrix'

    div(:outer_div)
    gxt_table(:a_nested_gxt_table) { |page| page.outer_div_element.gxt_table_element }
  end

  describe "Widget Element Locators" do

    context "when using Watir" do
      let(:watir_browser) { mock_watir_browser }
      let(:watir_page_object) { WidgetTestPageObject.new(watir_browser) }

      it "should find a gxt_table element" do
        expect(watir_browser).to receive(:div).with(:id => 'blah').and_return(watir_browser)
        element = watir_page_object.gxt_table_element(:id => 'blah')
        expect(element).to be_instance_of GxtTable
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
        expect(watir_browser).to receive(tag).with(:index => 0).and_return(watir_browser)
      end

      it "should work for a gxt_table" do
        mock_driver_for :div
        expect(default_identifier.default_gxt_table_element).not_to be_nil
      end

    end

    describe "gxt_table accessors" do
      context "when called on a page object" do
        it "should generate accessor methods" do
          expect(watir_page_object).to respond_to(:a_table_element)
        end

        it "should generate multiple accessor methods" do
          expect(watir_page_object).to respond_to(:some_table_elements)
        end

        it "should call a block on the element method when present" do
          expect(watir_page_object.gxt_block_table_element).to eql "block_gxt_table"
        end

        it "should call a block on the elements method when present" do
          expect(watir_page_object.gxt_multiple_block_table_elements).to eql "multiple_block_gxt_table"
        end
      end

      it "should retrieve the table element from the page" do
        expect(watir_browser).to receive(:div).and_return(watir_browser)
        element = watir_page_object.a_table_element
        expect(element).to be_instance_of GxtTable
      end

      it "should retrieve all table elements from the page" do
        expect(watir_browser).to receive(:divs).and_return([watir_browser])
        element = watir_page_object.some_table_elements
        expect(element[0]).to be_instance_of GxtTable
      end

      it "should be able to specify the plural form" do
        expect(watir_browser).to receive(:divs).and_return([watir_browser])
        element = watir_page_object.matrix_elements
        expect(element[0]).to be_instance_of WidgetMatrix
      end
    end
  end

  describe "Widget Elements-GxtTable" do
    describe "interface" do
      let(:gxt_table_element) { double('gxt_table_element') }

      before(:each) do
        allow(gxt_table_element).to receive(:rows).and_return(Array.new(2, Watir::TableRow))
      end

      context "for watir" do
        let(:watir_table) { GxtTable.new(gxt_table_element) }

        it "should return a table row when indexed" do
          expect(watir_table[1]).to be_instance_of PageObject::Elements::TableRow
        end

        it "should return the number of rows" do
          expect(watir_table.rows).to eql 2
        end
      end
    end
  end

  describe "Element with nested elements" do
    context "in Watir" do
      before(:each) do
        @watir_driver = instance_double('Watir::Element')
        @watir_element = PageObject::Elements::Element.new(@watir_driver)
      end

      it "should find a nested gxt_table" do
        expect(@watir_driver).to receive(:div)
        @watir_element.gxt_table_element
      end
    end
  end
end




