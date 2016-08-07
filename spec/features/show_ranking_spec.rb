feature "show ranking events process", type: :feature, js: true do
  background do
    @user = FactoryGirl.create(:user, coffee_counter: 5)
    FactoryGirl.create(:event, :done, owner: @user)
    login_as(@user)
  end

  scenario "shows ranking" do
    visit ranking_path

    expect(page).to have_content @user.email
  end
end
