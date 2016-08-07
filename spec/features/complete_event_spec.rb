feature "complete event process", type: :feature, js: true do
  background :each do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, owner: user, status: :open, people_amount: 4)
    FactoryGirl.create(:participation, user: user, event: event)
    FactoryGirl.create(:participation, user: user2, event: event)
    login_as(user)
  end

  scenario "it completes my event" do
    visit root_path
    click_on 'complete-event'
    expect(page).to have_content 'You have successfully completed the event!'
  end
end
