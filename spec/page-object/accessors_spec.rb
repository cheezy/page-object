require 'spec_helper'

class GenericPage
  include PageObject

  wait_for_expected_title 'expected title'
end

describe  'accessors' do
  let(:browser) { mock_watir_browser }
  let(:page) { GenericPage.new browser }

  context '#wait_for_expected_title' do
    before(:each) do
      allow(browser).to receive(:wait_until).and_yield
    end

    it 'true if already there' do
      allow(browser).to receive(:title).and_return 'expected title'
      expect(page.wait_for_expected_title?).to be_truthy
    end

    it 'errors when it does not match' do
      allow(browser).to receive(:title).and_return 'wrong title'
      expect { page.wait_for_expected_title? }.to raise_error "Expected title 'expected title' instead of 'wrong title'"
    end

    it 'picks up when the title changes' do
      allow(browser).to receive(:title).and_return 'wrong title', 'expected title'
      expect(page.wait_for_expected_title?).to be_truthy
    end

    it '#has_expected_title?' do
      allow(browser).to receive(:title).and_return 'wrong title', 'expected title'
      expect(page).to have_expected_title
    end
  end
end
