feature "extend event process", type: :feature, js: true do
  background :each do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, :expired, owner: user, people_amount: 3)
    FactoryGirl.create(:participation, user: user, event: event)
    FactoryGirl.create(:participation, user: user2, event: event)
    login_as(user)
  end

  scenario "it extends my event" do
    visit my_events_path
    click_on 'expired'
    click_on 'extend-event'
    expect(page).to have_content 'You have successfully extended the event!'
  end
end
