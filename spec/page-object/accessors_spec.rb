require 'spec_helper'

include RSpec::Matchers

describe PageObject::Accessors do
  context 'when declaring new elements on the page' do
    
    it "should check the name when adding an element" do
        class TestPage
          include PageObject

          def self.elements
            [
             'text_field',
             'hidden_field',
             'text_area',
             'select_list',
             'link',
             'checkbox',
             'radio_button',
             'radio_button_group',
             'button',
             'div',
             'span',
             'table',
             'cell',
             'image',
             'form',
             'list_item',
             'unordered_list',
             'ordered_list',
             'h1',
             'h2',
             'h3',
             'h4',
             'h5',
             'h6',
             'paragraph',
             'file_field',
             'label',
             'area',
             'canvas',
             'audio',
             'video',
             'svg',
             'address',
             'figure'
            ]
          end
          
          elements.each do |ele|
            expect {
              self.send ele, :platform, :id => 'foo'
            }.to raise_error(NameError, "Identifier \'platform\' conflicts with page-object method of the same name")
          end
        end
    end
    
  end
end
