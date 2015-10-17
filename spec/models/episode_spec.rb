require 'spec_helper'

describe Episode do
  subject { build :episode }

  it { is_expected.to be_valid }
  %i{ show title season number starts_at ends_at }.each do |attr|
    it { is_expected.to validate_presence_of(attr) }
  end

  describe "uniqueness" do
    context "when there is an exact episode already" do
      before do
        create :episode, show: "Dexter",
          season: 1, number: 4

        subject.show = "Dexter"
        subject.season = 1
        subject.number = 4
      end

      it "should be invalid" do
        expect(subject).to be_invalid
      end
    end
  end

  describe ".identifier" do
    context "after saving" do
      before do
        subject.show = 'American Horror Story'
        subject.season = 5
        subject.number = 2

        subject.save
      end

      it "should be set" do
        expect(subject.identifier).to eq('American Horror Story 5x02')
      end
    end
  end

  describe "#to_s" do
    before do
      allow(subject).to receive(:identifier) { 'Lost 1x01' }
    end

    it "should be .identifier" do
      expect(subject.to_s).to eq('Lost 1x01')
    end
  end

  describe "#term_for_torrent_site" do
    context "after saving" do
      before do
        subject.show = 'American Horror Story'
        subject.season = 5
        subject.number = 2

        subject.save
      end

      it "should be set" do
        expect(subject.term_for_torrent_site).
          to eq('American Horror Story s05e02 720p')
      end
    end
  end
end
