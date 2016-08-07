feature "show open events process", type: :feature, js: true do
  background do
    @user = FactoryGirl.create(:user)
    login_as(@user)
  end

  scenario "shows events" do
    FactoryGirl.create(:event, owner: @user)

    visit "/"

    expect(page).to have_content 'Example coffee event'
  end

  scenario "doesn't show events of other status" do
    FactoryGirl.create(:event, owner: @user, status: :test)

    visit "/"

    expect(page).not_to have_content 'Example coffee event'
  end
end
