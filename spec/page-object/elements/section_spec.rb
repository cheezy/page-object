require 'spec_helper'
require 'page-object/elements'

class Container < PageObject::Section;
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
      expect(watir_browser).to receive(:elements).with(:class => 'foo').and_return([watir_browser,watir_browser])
      sections = watir_page_object.containers
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
      expect(selenium_browser).to receive(:find_elements).with(:class, 'foo').and_return([selenium_browser,selenium_browser])
      sections = selenium_page_object.containers
      sections.each do |section|
        expect(section).to be_instance_of(Container)
      end
    end
  end
end
describe PageObject::Section do
  it 'should have accessors' do
    expect(PageObject::Section).to respond_to(:link, :div, :table, :indexed_property)
  end
end
