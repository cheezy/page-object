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
    let(:watir_browser) { mock_watir_browser }
    let(:watir_page_object) { SectionsPage.new(watir_browser) }

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
  context 'when using selenium' do
    let(:selenium_browser) { mock_selenium_browser }
    let(:selenium_page_object) { SectionsPage.new(selenium_browser) }

    it 'it should find a page section' do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      section = selenium_page_object.container
      expect(section).to be_instance_of Container
    end
    it 'it should find page sections' do
      expect(selenium_browser).to receive(:find_elements).with(:class, 'foo').and_return([selenium_browser, selenium_browser])
      sections = selenium_page_object.containers
      expect(sections).to be_instance_of(PageObject::SectionCollection)
      sections.each do |section|
        expect(section).to be_instance_of(Container)
      end
    end
  end
end
describe PageObject::SectionCollection do
  ContainedItem = Struct.new(:type, :name)
  let(:section_collection) do
    contained_items = [ContainedItem.new(:sandwich, :reuben), ContainedItem.new(:soup, :lobster_bisque), ContainedItem.new(:sandwich, :dagwood)]
    PageObject::SectionCollection[*contained_items]
  end
  it 'should inherit from Array' do
    expect(PageObject::SectionCollection.superclass).to eq Array
  end
  it 'should have functioning array methods' do
    expect(section_collection.methods).to include *Array.instance_methods
    expect(section_collection.last.type).to eq :sandwich
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
    expect(section_collection.select_by(type: :sandwich).map(&:type)).to eq [:sandwich, :sandwich]
  end
end
