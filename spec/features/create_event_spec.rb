require 'spec_helper'

feature "create event process", type: :feature, js: true do
  background do
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:user)
    login_as(user)
  end

  scenario "creates my event" do
    visit root_path

    click_on 'CREATE EVENT'

    within "#create" do
      fill_in 'event_description', with: 'I want to have a coffee in good companionship!'
    end

    click_on 'create-event'
    expect(page).to have_content 'You have successfully created the event!'
  end
end
