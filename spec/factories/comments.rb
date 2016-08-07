# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  event_id   :integer
#

FactoryGirl.define do
  factory :comment do
    text "This coffee tastes like mud rugrats!"
    association :user, factory: :user
    association :event, factory: :event
  end
end
