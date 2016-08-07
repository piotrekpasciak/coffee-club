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

class EventSerializer < ActiveModel::Serializer
  attributes :id, :description, :time_length, :remaining_time, :people_amount, :status, :user_id, :created_at, :updated_at,
             :participations_count, :participants_left, :current_user_member_of_event, :current_user_owner_of_event,
             :is_disabled, :owner, :path, :timer_active,
             :can_join, :can_leave, :can_complete, :can_confirm, :can_extend,
             :white_status, :participations, :comments

  has_many :comments, serializer: CommentSerializer
  has_many :participations, serializer: ParticipationSerializer

  def comments
    object.comments
  end

  def remaining_time
    object.remaining_time
  end

  def participations_count
    object.participations.count
  end

  def participants_left
    object.participants_left
  end

  def current_user_member_of_event
    current_user.member_of?(object)
  end

  def current_user_owner_of_event
    current_user.owner_of?(object)
  end

  def can_join
    !current_user.member_of?(object) && object.open?
  end

  def can_leave
    current_user.member_of?(object) && !(current_user == object.owner) && object.open?
  end

  def can_complete
    object.completable? && current_user.owner_of?(object) && current_user.member_of?(object) && (object.open? || object.expired?)
  end

  def can_confirm
    current_user.member_of?(object) && object.closed?
  end

  def can_extend
    current_user.owner_of?(object) && object.expired?
  end

  def white_status
    current_user.owner_of?(object) || object.closed? || object.done?
  end

  def timer_active
    object.open?
  end

  def owner
    object.owner.to_s
  end

  def path
    event_path(object.id)
  end

  def is_disabled
    object.expired?
  end
end
