feature "the signin process", type: :feature do
  background do
    @user = FactoryGirl.create(:user)
  end

  scenario "signs me in" do
    visit new_user_session_path

    within '#session-new' do
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
    end

    click_on 'Log in'
    expect(page).to have_content 'LOGOUT'
  end
end
