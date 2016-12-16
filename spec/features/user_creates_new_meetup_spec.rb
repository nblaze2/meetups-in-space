require "spec_helper"

feature "user adds a new meetup" do
  # As a user
  # I want to create a meetup
  # So that I can gather a group of people to do an activity

  # Acceptance Criteria:
  # There should be a link from the meetups index page that takes you to the meetups new page. On this page there is a form to create a new meetup.
  # I must be signed in, and I must supply a name, location, and description.
  # If the form submission is successful, I should be brought to the meetup's show page, and I should see a message that lets me know that I have created a meetup successfully.
  # If the form submission is unsuccessful, I should remain on the meetups new page, and I should see error messages explaining why the form submission was unsuccessful. The form should be pre-filled with the values that were provided when the form was submitted.
  scenario "successfully add a meetup" do

    visit "/meetups"
    click_link('Submit a New Meetup')

    fill_in('name', with: 'Unveiling the New Death Star')
    fill_in('location', with: 'Alderaan')
    fill_in('description', with: 'Watch as the pretty laser beam disrupts the force')
    click_button('Submit')

    expect(page).to have_content("Creator:")
    expect(page).to have_content("Alderaan")
    expect(page).to have_content("You have created an event.")

  end

  scenario "fail to add a meetup with invalid information" do
    visit "/meetups"
    click_link('Submit a New Meetup')

    click_button('Submit')
    click_button('Submit')

    expect(page).to have_content("Please fill out form completely")
  end
end
