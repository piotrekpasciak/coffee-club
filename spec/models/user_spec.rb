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

describe User do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  describe "#owner_of?(event)" do
    it "returns true for owner of event" do
      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, :done, owner: user)
      expect(user).to be_owner_of(event)
    end

    it "returns false for not owner of event" do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, :done, owner: user)
      expect(user2).not_to be_owner_of(event)
    end
  end

  describe "#member_of(event)?" do
    it "returns true for member of event" do
      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, :done, owner: user)
      FactoryGirl.create(:participation, user: user, event: event)
      expect(user).to be_member_of(event)
    end

    it "returns false for not a member of event" do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, :done, owner: user)
      FactoryGirl.create(:participation, user: user, event: event)
      expect(user2).not_to be_owner_of(event)
    end
  end

  describe "#top?(position)" do
    it "returns true for user with position in ranking at least of parameter_value" do
      FactoryGirl.create(:user, coffee_counter: 10)
      user = FactoryGirl.create(:user, coffee_counter: 5)

      expect(user).to be_top(2)
    end

    it "returns false for user with position in ranking lower then parameter_value" do
      FactoryGirl.create(:user, coffee_counter: 10)
      FactoryGirl.create(:user, coffee_counter: 6)
      user = FactoryGirl.create(:user, coffee_counter: 5)

      expect(user).not_to be_top(2)
    end
  end

  describe "#days_without_coffee?(amount)" do
    it "returns true for user who didn't drink yet coffee for amount_value days" do
      user = FactoryGirl.create(:user, coffee_counter: 0, created_at: Time.now - 5.days)

      expect(user).to be_days_without_coffee(4)
    end

    it "returns false for user who drank coffee in amount_value days or any coffee before" do
      user = FactoryGirl.create(:user, coffee_counter: 3, created_at: Time.now - 5.days)

      expect(user).not_to be_days_without_coffee(4)
    end
  end
end
