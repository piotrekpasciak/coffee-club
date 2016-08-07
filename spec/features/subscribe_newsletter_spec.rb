feature "subscribe to newsletter", type: :feature, js: true do
  background :each do
    user = FactoryGirl.create(:user)
    login_as(user)
  end

  scenario "it displays unsubscribe button" do
    visit root_path
    expect(page).to have_content "Unsubscribe"
  end

  scenario "it subscribes user to newsletter" do
    visit root_path

    within "#footer" do
      click_on "Unsubscribe"
      click_on "Subscribe"
    end

    expect(page).to have_content "You have subscribed for newsletter!"
  end

  scenario "it unsubscribes user from newsletter" do
    visit root_path

    within "#footer" do
      click_on "Unsubscribe"
    end

    expect(page).to have_content "You're no longer subscriber of newsletter!"
  end
end
