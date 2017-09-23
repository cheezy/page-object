require 'spec_helper'
require 'page-object/elements'

class Container
  include PageObject
end
class SectionsPage
  include PageObject

  page_section(:container, Container, :id => 'blah')
  page_sections(:containers, Container, :class => 'foo')
end

describe PageObject::Accessors do
  context 'when using watir' do
    let(:watir_browser) {mock_watir_browser}
    let(:watir_page_object) {SectionsPage.new(watir_browser)}

    it 'it should find a page section' do
      expect(watir_browser).to receive(:element).with(:id => 'blah').and_return(watir_browser)
      section = watir_page_object.container
      expect(section).to be_instance_of Container
    end
    it 'it should find page sections' do
      expect(watir_browser).to receive(:elements).with(:class => 'foo').and_return([watir_browser, watir_browser])
      sections = watir_page_object.containers
      expect(sections).to be_instance_of(PageObject::SectionCollection)
      sections.each do |section|
        expect(section).to be_instance_of(Container)
      end
    end
  end
end

describe PageObject::SectionCollection do
  ContainedItem = Struct.new(:type, :name) do
    def type? type_name
      type_name == type
    end
  end
  let(:contained_items) { [ContainedItem.new(:sandwich, :reuben), ContainedItem.new(:soup, :lobster_bisque), ContainedItem.new(:sandwich, :dagwood)] }

  let(:section_collection) do
    PageObject::SectionCollection[*contained_items]
  end
  context 'receiving array methods' do
    it 'should respond to the methods of the internal collection' do
      Array.instance_methods.each do |method|
        expect(section_collection).to respond_to method
      end
      expect(section_collection.last.type).to eq :sandwich
    end

    it 'selects and rejects down to a section collection' do
      new_collection = section_collection.select{|item| item.type == :sandwich}
      expect(new_collection).to be_a PageObject::SectionCollection
      expect(new_collection).to all be_type :sandwich
      new_collection = section_collection.reject{|item| item.type == :sandwich}
      expect(new_collection).to be_a PageObject::SectionCollection
      expect(new_collection).to all be_type :soup
    end

    it 'returns an array for to_a' do
      expect(section_collection.to_a).to eq contained_items
    end

    it 'returns the value from the block when calling map' do
      expect(section_collection.map(&:type)).to eq %i:sandwich soup sandwich:
    end

    it 'returns the first matching item when calling find' do
      found_item = section_collection.find {|item| item.type == :soup}
      expect(found_item).to be_a ContainedItem
      expect(found_item.name).to eq :lobster_bisque
    end

    it 'returns an item for first and last with no argument' do
      expect(section_collection.first).to be_a ContainedItem
      expect(section_collection.last).to be_a ContainedItem
    end

    it 'returns a section collection for first and last with an argument' do
      expect(section_collection.first(1)).to be_a PageObject::SectionCollection
      expect(section_collection.first(2)).to be_a PageObject::SectionCollection
      expect(section_collection.last(1)).to be_a PageObject::SectionCollection
      expect(section_collection.last(2)).to be_a PageObject::SectionCollection
    end
  end
  it 'should be indexed to the sections' do
    expect(section_collection[0]).to be_an_instance_of ContainedItem
    expect(section_collection[-1]).to be_an_instance_of ContainedItem
  end
  it 'should be able to iterate over the sections' do
    section_collection.each do |section|
      expect(section).to be_an_instance_of ContainedItem
    end
  end
  it 'should find a section by one of its values' do
    expect(section_collection.find_by(name: :dagwood).name).to eq :dagwood
  end
  it 'should find all sections matching a value' do
    section_collection_select_by = section_collection.select_by(type: :sandwich)
    expect(section_collection_select_by.map(&:type)).to eq [:sandwich, :sandwich]
  end
end
