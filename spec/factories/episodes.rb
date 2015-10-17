FactoryGirl.define do
  factory :episode do
    show "Fringe"
    title "The day JJ Abrams lost it"
    season 4
    number 1
    starts_at Time.new
    ends_at (Time.new + 30.minutes)
  end
end
