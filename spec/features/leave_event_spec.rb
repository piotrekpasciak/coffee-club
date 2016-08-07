feature "leave event process", type: :feature, js: true do
  background :each do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    login_as(user2)
    event = FactoryGirl.build(:event, user_id: user.id, people_amount: 3)
    FactoryGirl.create(:participation, user: user, event: event)
  end

  scenario "it leaves my event" do
    visit '/'
    click_on 'join-event'
    click_on 'leave-event'

    expect(page).to have_content 'You have left event!'
  end
end
