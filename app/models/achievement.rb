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

class Achievement < ActiveRecord::Base
  has_many :users, through: :user_achievements

  scope :not_shown, -> (current_user) { joins("LEFT JOIN user_achievements ON achievements.id = user_achievements.achievement_id")
                                        .where("user_achievements.shown = false AND user_achievements.user_id = ?", current_user.id) }

  validates :name, :symbol, :text, :image, presence: true
end
