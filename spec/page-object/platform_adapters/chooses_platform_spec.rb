require 'spec_helper'
module PageObject
  #
  # module which provides a function for determining
  # which platform to provide to the page object
  # 
  module ChoosesPlatform
    def determine_platform(browser, adapters)
      adapters.each { | adapter |
        return adapter.platform if adapter.is_for?(browser)
      }
      raise 'Unable to pick a platform for the provided browser' 
    end
  end
end
class TestChoosesPlatform
  include PageObject::ChoosesPlatform
end
describe TestChoosesPlatform do
  let(:subject) { TestChoosesPlatform.new }
  let(:adapters) { [] }
  context "when browser x is registered with platform nom_nom_nom" do
    let(:browser_x) { double('browser') }
    before { adapters << mock_adapter(browser_x,:nom_nom_nom) }
    it "returns platform nom_nom_nom  when asked about browser_x" do
      subject.determine_platform(browser_x, adapters).should == :nom_nom_nom
    end
    context "when browser a is registered with platform boom_boom_boom" do
      let(:browser_a) { double('browser') }
      before { adapters << mock_adapter(browser_a, :boom_boom_boom) }
      it "should return platform nom_nom_nom when asked about browser_x" do
        subject.determine_platform(browser_x, adapters).should == :nom_nom_nom
      end
    end
  end
  context "when browser a is registered with platform boom_boom_boom" do
    let(:browser_n) { double('browser') }
    before { adapters << mock_adapter(browser_n, :boom_boom_boom) }
    it "should return platform boom_boom_boom" do
      subject.determine_platform(browser_n, adapters).should == :boom_boom_boom
    end
  end

  context "When an unknow object is passed in" do
    it "should throw an exception" do
      expect {
        subject.determine_platform("browser")
      }.to raise_error
    end
  end
end
