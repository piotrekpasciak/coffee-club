# == Schema Information
#
# Table name: participations
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  event_id   :integer
#

# spec/factories/participations,rb

FactoryGirl.define do
  factory :participation do
    association :user, factory: :user
    association :event, factory: :event
  end
end
