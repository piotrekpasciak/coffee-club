# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  description   :string(160)
#  time_length   :integer
#  people_amount :integer
#  status        :string
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :event do
    description "Example coffee event"
    time_length 30
    people_amount 2
    status :open
    owner factory: :user
  end

  trait :closed do
    status :closed
  end

  trait :done do
    status :done
  end

  trait :expired do
    status :expired
    time_length 0
  end
end
