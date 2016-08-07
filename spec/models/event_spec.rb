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

RSpec.describe Event, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }

  it "has a valid factory" do
    expect(FactoryGirl.create(:event)).to be_valid
  end

  describe "#open?" do
    it "returns true for open event" do
      event = FactoryGirl.create(:event)
      expect(event).to be_open
    end

    it "returns false for other type of event" do
      event = FactoryGirl.create(:event, :closed)
      expect(event).not_to be_open
    end
  end

  describe "#closed?" do
    it "returns true for closed event" do
      event = FactoryGirl.create(:event, :closed)
      expect(event).to be_closed
    end

    it "returns false for other type of event" do
      event = FactoryGirl.create(:event)
      expect(event).not_to be_closed
    end
  end

  describe "#done?" do
    it "returns true for done event" do
      event = FactoryGirl.create(:event, :done)
      expect(event).to be_done
    end

    it "returns false for other type of event" do
      event = FactoryGirl.create(:event)
      expect(event).not_to be_done
    end
  end

  describe "#expired?" do
    it "returns true for expired event" do
      event = FactoryGirl.create(:event, :expired)
      expect(event).to be_expired
    end

    it "return false for other type of event" do
      event = FactoryGirl.create(:event)
      expect(event).not_to be_expired
    end
  end

  describe "#full?" do
    it "returns false for not full event" do
      event = FactoryGirl.create(:event, status: :open)
      expect(event).not_to be_full
    end

    it "returns true for full event" do
      event = FactoryGirl.create(:event)
      FactoryGirl.create(:participation, user: user, event: event)
      FactoryGirl.create(:participation, user: user2, event: event)
      expect(event).to be_full
    end
  end

  describe "#completable?" do
    it "returns false for event with only owner" do
      event = FactoryGirl.create(:event, people_amount: 4)
      FactoryGirl.create(:participation, user: user, event: event)

      expect(event).not_to be_completable
    end

    it "returns true for event with at least 2 participants" do
      event = FactoryGirl.create(:event, people_amount: 4)
      FactoryGirl.create(:participation, user: user, event: event)
      FactoryGirl.create(:participation, user: user2, event: event)

      expect(event).to be_completable
    end
  end

  describe "#expirable?" do
    it "returns false for event with remaining time" do
      event = FactoryGirl.create(:event, time_length: 30)

      expect(event).not_to be_expirable
    end

    it "returns true for event with no remaining time" do
      event = FactoryGirl.create(:event, time_length: 0)

      expect(event).to be_expirable
    end
  end

  describe "#remaining_time" do
    it "returns remaining time in seconds" do
      event = FactoryGirl.create(:event, time_length: 30)
      expect(event.remaining_time). to eq(1800)
    end
  end

  describe "#participants_left" do
    it "returns number of participants" do
      event = FactoryGirl.create(:event, people_amount: 2)
      FactoryGirl.create(:participation, user: user, event: event)
      expect(event.participants_left).to eq(1)
    end
  end

  describe "#participants_emails" do
    it "returns number of participants" do
      event = FactoryGirl.create(:event, people_amount: 2)
      FactoryGirl.create(:participation, user: user, event: event)
      expect(event.participants_emails.size).to eq(1)
    end
  end
end
