require 'spec_helper'
require 'page-object/elements'


describe "Element with nested elements" do
  context "in Watir" do
    before(:each) do
      @watir_driver = Watir::Element.new(nil, {})
      @watir_element = PageObject::Elements::Element.new(@watir_driver, :platform => :watir_webdriver)
    end
    
    it "should find nested links" do
      @watir_driver.should_receive(:link).with(:id => 'blah').and_return(@watir_driver)
      @watir_element.link_element(:id => 'blah')
    end

    it "should find nested buttons" do
      @watir_driver.should_receive(:button).with(:id => 'blah').and_return(@watir_driver)
      @watir_element.button_element(:id => 'blah')
    end
    
    it "should find nested text fields" do
      @watir_driver.should_receive(:text_field).with(:id => 'blah').and_return(@watir_driver)
      @watir_element.text_field_element(:id => 'blah')
    end

    it "should find nested hidden fields" do
      @watir_driver.should_receive(:hidden).and_return(@watir_driver)
      @watir_element.hidden_field_element
    end

    it "should find nested text areas" do
      @watir_driver.should_receive(:textarea).and_return(@watir_driver)
      @watir_element.text_area_element
    end

    it "should find a nested select list" do
      @watir_driver.should_receive(:select_list).and_return(@watir_driver)
      @watir_element.select_list_element
    end

    it "should find a nested checkbox" do
      @watir_driver.should_receive(:checkbox).and_return(@watir_driver)
      @watir_element.checkbox_element
    end
    
    it "should find a nested radio button" do
      @watir_driver.should_receive(:radio).and_return(@watir_driver)
      @watir_element.radio_button_element
    end
    
    it "should find a nested div" do
      @watir_driver.should_receive(:div).and_return(@watir_driver)
      @watir_element.div_element
    end
    
    it "should find a nested span" do
      @watir_driver.should_receive(:span).and_return(@watir_driver)
      @watir_element.span_element
    end
    
    it "should find a nested table" do
      @watir_driver.should_receive(:table).and_return(@watir_driver)
      @watir_element.table_element
    end

    it "should find a nested cell" do
      @watir_driver.should_receive(:td).and_return(@watir_driver)
      @watir_element.cell_element
    end
    
    it "should find a nested image" do
      @watir_driver.should_receive(:image).and_return(@watir_driver)
      @watir_element.image_element
    end
    
    it "should find a nested form" do
      @watir_driver.should_receive(:form).and_return(@watir_driver)
      @watir_element.form_element
    end
    
    it "should find a nested ordered list" do
      @watir_driver.should_receive(:ol).and_return(@watir_driver)
      @watir_element.ordered_list_element
    end
    
    it "should find a nested unordered list" do
      @watir_driver.should_receive(:ul).and_return(@watir_driver)
      @watir_element.unordered_list_element
    end
    
    it "should find a nested list item" do
      @watir_driver.should_receive(:li).and_return(@watir_driver)
      @watir_element.list_item_element
    end
    
    it "should find a nested h1" do
      @watir_driver.should_receive(:h1).and_return(@watir_driver)
      @watir_element.h1_element
    end

    it "should find a nested h2" do
      @watir_driver.should_receive(:h2).and_return(@watir_driver)
      @watir_element.h2_element
    end

    it "should find a nested h3" do
      @watir_driver.should_receive(:h3).and_return(@watir_driver)
      @watir_element.h3_element
    end

    it "should find a nested h4" do
      @watir_driver.should_receive(:h4).and_return(@watir_driver)
      @watir_element.h4_element
    end

    it "should find a nested h5" do
      @watir_driver.should_receive(:h5).and_return(@watir_driver)
      @watir_element.h5_element
    end

    it "should find a nested h6" do
      @watir_driver.should_receive(:h6).and_return(@watir_driver)
      @watir_element.h6_element
    end
  end
  
  context "in Selenium" do
    before(:each) do
      @selenium_driver = double('selenium')
      @selenium_element = PageObject::Elements::Element.new(@selenium_driver, :platform => :selenium_webdriver)
    end

    it "should find nested links" do
      @selenium_driver.should_receive(:find_element).with(:id, 'blah').and_return(@selenium_driver)
      @selenium_element.link_element(:id => 'blah')
    end

    it "should find nested buttons" do
      @selenium_driver.should_receive(:find_element).with(:id, 'blah').and_return(@selenium_driver)
      @selenium_element.button_element(:id => 'blah')
    end
    
    it "should find nested text fields" do
      @selenium_driver.should_receive(:find_element).with(:id, 'blah').and_return(@selenium_driver)
      @selenium_element.text_field_element(:id => 'blah')
    end
    
    it "should find nested hidden fields" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.hidden_field_element
    end
    
    it "should find nested text areas" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.text_area_element
    end
    
    it "should find a nested select list" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.select_list_element
    end
    
    it "should find a nested checkbox" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.checkbox_element
    end
    
    it "should find a nested radio button" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.radio_button_element
    end
    
    it "should find a nested div" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.div_element
    end
    
    it "should find a nested span" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.span_element
    end
    
    it "should find a nested table" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.table_element
    end

    it "should find a nested cell" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.cell_element
    end
    
    it "should find a nested image" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.image_element
    end
    
    it "should find a nested form" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.form_element
    end
    
    it "should find an ordered list" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.ordered_list_element
    end
    
    it "should find an unordered list" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.unordered_list_element
    end
    
    it "should find a nested list item" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.list_item_element
    end
    
    it "should find a nested h1" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.h1_element
    end
    
    it "should find a nested h2" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.h2_element
    end

    it "should find a nested h3" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.h3_element
    end

    it "should find a nested h4" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.h4_element
    end

    it "should find a nested h5" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.h5_element
    end

    it "should find a nested h6" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.h6_element
    end

    it "should find a nested paragraph" do
      @selenium_driver.should_receive(:find_element).and_return(@selenium_driver)
      @selenium_element.paragraph_element
    end
  end
end
