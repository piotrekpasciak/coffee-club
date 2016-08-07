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

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :user, :event, :text, presence: true
  validates :text, length: { maximum: 400 }
end
