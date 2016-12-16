require "spec_helper"

feature "user sees who has already joined meetup" do
  # As a user
  # I want to see who has already joined a meetup
  # So that I can see if any of my friends have joined

  # Acceptance Criteria:
  # On a meetup's show page, I should see a list of the members that have joined the meetup.
  # I should see each member's avatar and username.

  scenario "user sees who has joined" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user, username: "Jean Luc")
    user3 = FactoryGirl.create(:user, username: "Will")
    user4 = FactoryGirl.create(:user, username: "Jordy")
    user5 = FactoryGirl.create(:user, username: "Data")

    visit "/"
    sign_in_as user
    iron_banner = FactoryGirl.create(:meetup)

    Usermeetup.create(user_id: user2.id, meetup_id: iron_banner.id)
    Usermeetup.create(user_id: user3.id, meetup_id: iron_banner.id)
    Usermeetup.create(user_id: user4.id, meetup_id: iron_banner.id)
    Usermeetup.create(user_id: user5.id, meetup_id: iron_banner.id)

    visit "/meetups"

    click_link iron_banner.name

    expect(page).to have_content("Jean Luc")
    expect(page).to have_content("Will")
    expect(page).to have_content("Jordy")
    expect(page).to have_content("Data")
  end
end
