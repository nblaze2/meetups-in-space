require "spec_helper"

feature "user views details of a meetup" do
  # As a user
  # I want to view the details of a meetup
  # So that I can learn more about its purpose

  # Acceptance Criteria:
  # On the index page, the name of each meetup should be a link to the meetup's show page.
  # On the show page, I should see the name, description, location, and the creator of the meetup.

  scenario "view details of meetup" do

    iron_banner = FactoryGirl.create(:meetup)
    wotm_raid = FactoryGirl.create(:meetup,
      name: "Wrath of the Machine Raid",
      description: "Battle through hoardes of Splicers to defeat their leader Vosik",
      location: "Plaguelands, Russia, Earth")
    rogue_one = FactoryGirl.create(:meetup,
      name: "Rogue One Viewing",
      location: "Revere",
      creator: "Keith Mahoney")

    visit "/meetups"
    click_link rogue_one.name

    expect(page).to have_content rogue_one.name
    expect(page).to have_content rogue_one.location
    expect(page).to have_content rogue_one.description
    expect(page).to have_content rogue_one.creator
  end
end
