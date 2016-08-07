# == Schema Information
#
# Table name: users
#
#  id                          :integer          not null, primary key
#  email                       :string           default(""), not null
#  encrypted_password          :string           default(""), not null
#  reset_password_token        :string
#  reset_password_sent_at      :datetime
#  remember_created_at         :datetime
#  sign_in_count               :integer          default(0), not null
#  current_sign_in_at          :datetime
#  last_sign_in_at             :datetime
#  current_sign_in_ip          :inet
#  last_sign_in_ip             :inet
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  coffee_counter              :integer          default(0), not null
#  newsletter                  :boolean          default(FALSE), not null
#  temporary_newsletter        :boolean          default(FALSE), not null
#  temporary_newsletter_status :boolean          default(FALSE), not null
#  remember_token              :string
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  has_many :comments
  has_many :participations
  has_many :events, through: :participations
  has_many :user_achievements
  has_many :achievements, through: :user_achievements

  scope :newsletter_member, -> { where("users.newsletter = true OR users.temporary_newsletter = true") }

  def to_s
    self.email
  end

  def event_counter
    Event.where(owner: self, status: "done").count
  end

  def top?(position)
    User.limit(position).order("coffee_counter DESC").include?(self) && self.coffee_counter > 0
  end

  def days_without_coffee?(amount)
    Time.now - self.created_at > amount.days && self.coffee_counter == 0
  end

  def member_of?(event)
    event.participations.where(user: self).take.present?
  end

  def owner_of?(event)
    self == event.owner
  end
end
