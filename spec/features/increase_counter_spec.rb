feature "counter displaying", type: :feature, js: true do
  background :each do
    user = FactoryGirl.create(:user, coffee_counter: 3)
    user2 = FactoryGirl.create(:user, coffee_counter: 6)
    login_as(user)
  end

  scenario "it displays correct counters" do
    visit root_path
    expect(page).to have_content 'You have drunk 3 of 9 coffees.'
  end
end
