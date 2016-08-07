feature "confirm event process", type: :feature, js: true do
  background :each do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    event = FactoryGirl.build(:event, user_id: user.id, people_amount: 2)
    FactoryGirl.create(:participation, user: user, event: event)
    FactoryGirl.create(:participation, user: user2, event: event)
    event.update(status: "closed")
    login_as(user2)
  end

  scenario "it confirms my event" do
    visit my_events_path
    click_on 'closed'
    click_on 'confirm-event'
    expect(page).to have_content 'You have successfully confirmed the event!'
  end
end
