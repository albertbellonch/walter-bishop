require 'spec_helper'

describe Episode do
  subject { create :episode }

  it { should be_valid }
  [ :tv_series, :title, :season, :number, :start_time, :end_time ].each do |attr|
    it { should validate_presence_of(attr) }
  end

  describe "uniqueness" do
    it "should be true when tv_series, season and number are unique" do
      FactoryGirl.create :episode, :tv_series => "Dexter", :season => 1, :number => 4
      subject.tv_series = "Dexter"
      subject.season = 1
      subject.number = 2

      subject.should be_valid
    end

    it "should be false when tv_series, season and number are not unique" do
      FactoryGirl.create :episode, :tv_series => "Dexter", :season => 1, :number => 4
      subject.tv_series = "Dexter"
      subject.season = 1
      subject.number = 4

      subject.should be_invalid
    end
  end
end
