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

class ParticipationSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :event_id, :user

  def user
    object.user.to_s
  end
end
