feature "achievement process", type: :feature, js: true do
  background :each  do
    @user = FactoryGirl.create(:user, coffee_counter: 1)
    @event = FactoryGirl.create(:event, :closed)
    FactoryGirl.create(:participation, user: @user, event: @event)
    @achievement = FactoryGirl.create(:achievement, :ach_1)
    login_as(@user)
  end

  scenario "shows my achievement after login" do
    FactoryGirl.create(:user_achievement, achievement: @achievement, user: @user, shown: false)

    visit root_path

    expect(page).to have_content "You have drank your first coffee!"
  end

  scenario "shows my achievement after confirmation of event" do
    visit my_events_path
    click_on 'closed'
    click_on 'confirm-event'

    expect(page).to have_content "You have drank your first coffee!"
  end
end
