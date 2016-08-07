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

class Event < ActiveRecord::Base
  belongs_to :owner, foreign_key: :user_id, class_name: "User"

  has_many :participations
  has_many :comments, -> { order(created_at: :desc) }
  has_many :users, through: :participations

  validates :description, :time_length, :people_amount, :status, presence: true

  validates :description, length: { maximum: 160 }
  validates :owner, presence: true

  scope :open_status, -> { where(status: :open) }
  scope :closed_status, -> { where(status: :closed) }
  scope :done_status, -> { where(status: :done) }
  scope :expired_status, -> { where(status: :expired) }

  scope :non_expirable, -> { where(%q{ events.time_length*60 - extract(epoch from(CURRENT_TIMESTAMP::timestamp - events.created_at::timestamp)) > 0 }) }
  scope :expirable, -> { where(%q{ events.time_length*60 - extract(epoch from(CURRENT_TIMESTAMP::timestamp - events.created_at::timestamp)) <= 0 }) }

  scope :all_and_open_non_expirable, -> { where(%q{ events.status != 'open' OR (events.status = 'open' AND events.time_length*60 - extract(epoch from(CURRENT_TIMESTAMP::timestamp - events.created_at::timestamp)) > 0) }) }

  def open?
    self.status == 'open'
  end

  def closed?
    self.status == 'closed'
  end

  def done?
    self.status == 'done'
  end

  def expired?
    self.status == 'expired'
  end

  def full?
    self.participations.count >= self.people_amount
  end

  def completable?
    self.participations.count >= 2
  end

  def non_expirable?
    !self.open? || self.remaining_time > 0
  end

  def expirable?
    self.expired? || self.open? && self.remaining_time <= 10
  end

  def remaining_time
    self.time_length * 60 - (Time.now - self.created_at).to_i
  end

  def participants_left
    self.people_amount - self.participations.count
  end

  def participants_emails
    self.users.pluck(:email)
  end
end
