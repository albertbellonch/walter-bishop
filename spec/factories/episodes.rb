FactoryGirl.define do
  factory :episode do
    tv_series "Fringe"
    title "The day JJ Abrams lost it"
    season 4
    number 1
    start_time Time.new
    end_time (Time.new + 30.minutes)
  end
end
