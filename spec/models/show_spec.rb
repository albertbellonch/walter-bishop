require 'spec_helper'

describe Show do
  subject { build :show }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }

  describe "#to_s" do
    before do
      allow(subject).to receive(:name) { 'Hannibal' }
    end

    it "should be .identifier" do
      expect(subject.to_s).to eq('Hannibal')
    end
  end
end
