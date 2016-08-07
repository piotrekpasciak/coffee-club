# == Schema Information
#
# Table name: user_achievements
#
#  id             :integer          not null, primary key
#  shown          :boolean          default(FALSE)
#  user_id        :integer          not null
#  achievement_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :user_achievement do
    association :user, factory: :user
    association :achievement, factory: :achievement
    shown false
  end
end
