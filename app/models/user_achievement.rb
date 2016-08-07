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

class UserAchievement < ActiveRecord::Base
  belongs_to :user
  belongs_to :achievement

  validates :user, :achievement, presence: true

  validates_uniqueness_of :user_id, scope: :achievement_id
end
