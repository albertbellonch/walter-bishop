require 'spec_helper'

describe Episode do
  subject { build :episode }

  it { is_expected.to be_valid }
  %i{ tv_series title season number start_time end_time }.each do |attr|
    it { is_expected.to validate_presence_of(attr) }
  end

  describe "uniqueness" do
    context "when there is an exact episode already" do
      before do
        create :episode, tv_series: "Dexter",
          season: 1, number: 4

        subject.tv_series = "Dexter"
        subject.season = 1
        subject.number = 4
      end

      it "should be invalid" do
        expect(subject).to be_invalid
      end
    end
  end

  describe "identifier" do
    context "after saving" do
      before do
        subject.tv_series = 'American Horror Story'
        subject.season = 5
        subject.number = 2

        subject.save
      end

      it "should be set" do
        expect(subject.identifier).to eq('American Horror Story 5x02')
      end
    end
  end
end
