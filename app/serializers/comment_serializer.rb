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

class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :user, :created_at, :updated_at

  def user
    object.user.to_s
  end
end
