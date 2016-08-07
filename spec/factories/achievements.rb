# == Schema Information
#
# Table name: achievements
#
#  id         :integer          not null, primary key
#  name       :string
#  text       :text
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  symbol     :string           not null
#

FactoryGirl.define do
  factory :achievement do
    name "Coffee"
    symbol "coffee"
    text "You have drank a lot of coffee!"
    image "coffee.png"
  end

  trait :ach_1 do
    name "First coffee!"
    symbol "first_coffee"
    text "You have drank your first coffee!"
  end

  trait :ach_2 do
    name "10 coffees!"
    symbol "10_coffees"
    text "You have drank 10 coffees already!"
  end

  trait :ach_3 do
    name "100 coffees!"
    symbol "100_coffees"
    text "You're real coffee addict!"
  end

  trait :ach_4 do
    name "First event!"
    symbol "first_event"
    text "You have organized your first event!"
  end

  trait :ach_5 do
    name "10 events!"
    symbol "10_events"
    text "You have organized 10 events already!"
  end

  trait :ach_6 do
    name "100 events!"
    symbol "100_events"
    text "You have organized 100 events already!"
  end

  trait :ach_7 do
    name "Highscores!"
    symbol "highscores"
    text "You have entered highscores!"
  end

  trait :ach_8 do
    name "Third place!"
    symbol "third_place"
    text "You are on third place!"
  end

  trait :ach_9 do
    name "Second place!"
    symbol "second_place"
    text "You are on second place!"
  end

  trait :ach_10 do
    name "Coffee leader!"
    symbol "coffee_leader"
    text "You've become a coffee leader!"
  end

  trait :ach_11 do
    name "NO for coffee!"
    symbol "no_coffee"
    text "You've joined application and didn't drink coffee for a week already!"
  end

  trait :ach_12 do
    name "Golden vulture!"
    symbol "golden_vulture"
    text "You have mastered the craft of vulture! You have drunk 10 coffees without creating your own events!"
  end
end
