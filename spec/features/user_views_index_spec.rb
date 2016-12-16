require "spec_helper"

feature "user views list of all meetups" do
  # As a user
  # I want to view a list of all available meetups
  # So that I can get together with people with similar interests

  # Acceptance Criteria:
  # On the meetups index page, I should see the name of each meetup.
  # Meetups should be listed alphabetically.

  scenario "view list of meetups" do
    # First create some sample meetups
    iron_banner = FactoryGirl.create(:meetup)
    wotm_raid = FactoryGirl.create(:meetup,
      name: "Wrath of the Machine Raid",
      description: "Battle through hoardes of Splicers to defeat their leader Vosik",
      location: "Plaguelands, Russia, Earth")
    rogue_one = FactoryGirl.create(:meetup, name: "Rogue One Viewing", location: "Revere")


    # The user visits the index page
    visit "/meetups"
    # And should see all the meetups
    expect(page).to have_content("Iron Banner")
    expect(page).to have_content("Wrath of the Machine Raid")
    expect(page).to have_content("Rogue One Viewing")
  end
end
