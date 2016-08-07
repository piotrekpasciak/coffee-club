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

class AchievementSerializer < ActiveModel::Serializer
  attributes :id, :name, :symbol, :text, :image, :image_path, :created_at, :updated_at

  def image_path
    ActionController::Base.helpers.asset_path(self.image, type: :image)
  end
end
