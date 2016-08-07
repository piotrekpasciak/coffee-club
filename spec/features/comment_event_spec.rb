feature "comment event process", type: :feature, js: true do
  background :each do
    user = FactoryGirl.create(:user)
    @event = FactoryGirl.create(:event, :done)
    FactoryGirl.create(:participation, user: user, event: @event)
    login_as(user)
  end

  scenario "it comments my done event" do
    visit event_path(@event.id)

    within "#comment" do
      fill_in 'comment_text', with: 'Coffee was marvelous!'
    end

    click_on 'Add comment'
    expect(page).to have_content 'You have successfully created the comment!'
  end
end
