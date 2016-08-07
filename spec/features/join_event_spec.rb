feature "join event process", type: :feature, js: true do
  background :each do
    @user = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
    login_as(@user2)
    @event = FactoryGirl.build(:event, user_id: @user.id)
    FactoryGirl.create(:participation, user: @user, event: @event)
  end

  scenario "it joins my event" do
    visit "/"
    click_on 'join-event'

    expect(page).to have_content 'You have successfully joined the event!'
  end

  scenario "it returns notice that i'm already member of this event" do
    visit "/"
    FactoryGirl.create(:participation, user: @user2, event: @event)
    click_on 'join-event'

    expect(page).to have_content "You're already member of this event!"
  end

  scenario "it returns response that event is already full" do
    visit "/"

    user3 = FactoryGirl.create(:user)
    user4 = FactoryGirl.create(:user)

    FactoryGirl.create(:participation, user: user3, event: @event)
    FactoryGirl.create(:participation, user: user4, event: @event)

    click_on 'join-event'

    expect(page).to have_content "Event is full!"
  end

  scenario "it returns response that event is already closed" do
    visit "/"

    @event.update(status: :closed)

    click_on 'join-event'

    expect(page).to have_content "Event is already closed!"
  end
end
