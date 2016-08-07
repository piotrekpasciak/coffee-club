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

class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :user, :event, presence: true
end
