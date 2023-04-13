require "rails_helper"

RSpec.describe "face management" do
  it "can manage the various aspects of die faces" do
    user = create :user, password: "Password1@"
    game = create :game, created_by: user
    die = create :die, game: game
    visit "/users/sign_in"
    fill_in "Email", with: user.email
    fill_in "Password", with: "Password1@"
    click_button "Log In"

    expect(page).to have_text("Welcome")

    visit game_dice_path(die.game)

    expect(page).to have_text(die.name)

    click_on "Faces"

    expect(page).to have_text("Faces for #{die.name}")

    click_on "New face"

    expect(page).to have_text("Back to faces")

    fill_in "Name", with: "Face name"
    fill_in "Count", with: 1
    click_button "Save"

    expect(page).to have_text("Face name: 1")

    click_on("Edit this face")

    expect(page).to have_text("Back to faces")

    fill_in "Name", with: "New name for face"
    fill_in "Count", with: 2
    click_button "Save"

    expect(page).to have_text("New name for face: 2")
    expect(page).not_to have_text("Face name")

    click_button "Delete"

    expect(page).to have_text("Faces for #{die.name}")
    expect(page).not_to have_text("New name for face")
  end
end
