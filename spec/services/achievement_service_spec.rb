describe AchievementService do
  let(:user_ach_1) { FactoryGirl.create :user, coffee_counter: 1 }
  let(:user_ach_2) { FactoryGirl.create :user, coffee_counter: 10 }
  let(:user_ach_3) { FactoryGirl.create :user, coffee_counter: 100 }
  let(:old_user) { FactoryGirl.create :user, created_at: Time.now - 7.days, coffee_counter: 0 }
  let(:user) { FactoryGirl.create :user, coffee_counter: 10 }
  let(:event) { FactoryGirl.create :event, :done }
  let(:open_event) { FactoryGirl.create :event }

  before :all do
    FactoryGirl.create :achievement, :ach_1
    FactoryGirl.create :achievement, :ach_2
    FactoryGirl.create :achievement, :ach_3
    FactoryGirl.create :achievement, :ach_4
    FactoryGirl.create :achievement, :ach_5
    FactoryGirl.create :achievement, :ach_6
    FactoryGirl.create :achievement, :ach_7
    FactoryGirl.create :achievement, :ach_8
    FactoryGirl.create :achievement, :ach_9
    FactoryGirl.create :achievement, :ach_10
    FactoryGirl.create :achievement, :ach_11
    FactoryGirl.create :achievement, :ach_12
  end

  it "returns 'First coffee!' achievement" do
    achievements = AchievementService.new(user_ach_1).call

    expect(achievements.map(&:name)).to include "First coffee!"
  end

  it "returns '10 coffees!' achievement" do
    achievements = AchievementService.new(user_ach_2).call

    expect(achievements.map(&:name)).to include "10 coffees!"
  end

  it "returns '100 coffees!' achievement" do
    achievements = AchievementService.new(user_ach_3).call

    expect(achievements.map(&:name)).to include "100 coffees!"
  end

  it "returns 'First event!' achievement" do
    FactoryGirl.create :event, :done, owner: user

    achievements = AchievementService.new(user).call

    expect(achievements.map(&:name)).to include "First event!"
  end

  it "returns '10 events!' achievement" do
    10.times { FactoryGirl.create :event, :done, owner: user }

    achievements = AchievementService.new(user).call

    expect(achievements.map(&:name)).to include "10 events!"
  end

  it "returns '100 events!' achievement" do
    100.times { FactoryGirl.create :event, :done, owner: user }

    achievements = AchievementService.new(user).call

    expect(achievements.map(&:name)).to include "100 events!"
  end

  it "returns 'Highscores!' achievement" do
    9.times { FactoryGirl.create :user, coffee_counter: 10 }
    achievements = AchievementService.new(user).call

    expect(achievements.map(&:name)).to include "Highscores!"
  end

  it "returns 'Third place!' achievement" do
    2.times { FactoryGirl.create :user, coffee_counter: 10 }

    achievements = AchievementService.new(user).call

    expect(achievements.map(&:name)).to include "Third place!"
  end

  it "returns 'Second place!' achievement" do
    FactoryGirl.create :user, coffee_counter: 10
    achievements = AchievementService.new(user).call

    expect(achievements.map(&:name)).to include "Second place!"
  end

  it "returns 'Coffee leader!' achievement" do
    achievements = AchievementService.new(user).call

    expect(achievements.map(&:name)).to include "Coffee leader!"
  end

  it "returns 'NO for coffee!' achievement" do
    achievements = AchievementService.new(old_user).call

    expect(achievements.map(&:name)).to include "NO for coffee!"
  end

  it "returns 'Golden vulture!' achievement" do
    achievements = AchievementService.new(user).call

    expect(achievements.map(&:name)).to include "Golden vulture!"
  end
end
