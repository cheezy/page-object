require 'spec_helper'
class TestLoadsPlatform
  include PageObject::LoadsPlatform
end
describe TestLoadsPlatform do
  let(:subject) { TestLoadsPlatform.new }
  let(:adapters) { {} }

  context "when browser x is registered with platform nom_nom_nom" do
    let(:browser_x) { double('browser') }
    before { adapters[:browser_x] = mock_adapter(browser_x, :nom_nom_nom) }

    it "returns platform nom_nom_nom  when asked about browser_x" do
      expect(subject.load_platform(browser_x, adapters)).to eql :nom_nom_nom
    end
    
    context "when browser a is registered with platform boom_boom_boom" do
      let(:browser_a) { double('browser') }
      before { adapters[:browser_a] = mock_adapter(browser_a, :boom_boom_boom) }
      
      it "should return platform nom_nom_nom when asked about browser_x" do
        expect(subject.load_platform(browser_x, adapters)).to eql :nom_nom_nom
      end
    end
  end
  
  context "when browser a is registered with platform boom_boom_boom" do
    let(:browser_n) { double('browser') }
    before { adapters[:browser_n] = mock_adapter(browser_n, :boom_boom_boom) }

    it "should return platform boom_boom_boom" do
      expect(subject.load_platform(browser_n, adapters)).to eql :boom_boom_boom
    end
  end

  context "When an unknow object is passed in" do
    let(:basic_message) { 'Unable to pick a platform for the provided browser or element:' }
    
    it "should throw an exception" do
      expect {
        subject.load_platform("browser", {})
      }.to raise_error("#{basic_message} \"browser\".")
    end

    it "should notify when the browser is nil" do
      begin
        subject.load_platform(nil, {})
      rescue Exception => e
        expect(e.message).to eql "#{basic_message} nil.\nnil was passed to the PageObject constructor instead of a valid browser or element object."
      end
    end
  end
end
