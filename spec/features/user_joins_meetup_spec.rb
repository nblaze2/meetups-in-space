require "spec_helper"

feature "user joins a meetup" do
  # As a user
  # I want to join a meetup
  # So that I can partake in this meetup

  # Acceptance Criteria:
  # On a meetup's show page, there should be a button to join the meetup if I am not signed in or if I am signed in, but I am not a member of the meetup.
  # If I am signed in and I click the button, I should see a message that says that I have joined the meetup and I should be added to the meetup's members list.
  # If I am not signed in and I click the button, I should see a message which says that I must sign in.


  scenario "user isn't signed in and fails joining meetup" do
    user = FactoryGirl.create(:user)
    iron_banner = FactoryGirl.create(:meetup)

    visit "/meetups"
    click_link "Iron Banner"
    click_button('Join this meetup')
    save_and_open_page
    expect(page).to have_content("You must sign in first to join this meetup")
  end

  scenario "user is signed in, succeeds in joining meetup" do
    user = FactoryGirl.create(:user)
    iron_banner = FactoryGirl.create(:meetup)

    visit "/meetups"
    sign_in_as user
    click_link "Iron Banner"
    click_button('Join this meetup')
    save_and_open_page
    expect(page).to have_content("You have successfully joined this meetup")
    expect(page).to have_content("jarlax")
  end

  scenario 'user is signed in and is already a member of meetup' do
    # add user to members
    user = FactoryGirl.create(:user)
    iron_banner = FactoryGirl.create(:meetup)

    visit "/meetups"
    click_link "Iron Banner"
    click_button('Join this meetup')
    visit "/meetups"
    click_link "Iron Banner"
    save_and_open_page
    expect(page).to_not have_selector(:link_or_button, 'Join this meetup')
  end
end
