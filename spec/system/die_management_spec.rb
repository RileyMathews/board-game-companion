require "rails_helper"

RSpec.describe "die management" do
  it "can manage the various aspects of dice" do
    user = create :user, password: "Password1@"
    game = create :game, created_by: user
    visit "/users/sign_in"
    fill_in "Email", with: user.email
    fill_in "Password", with: "Password1@"
    click_button "Log In"

    expect(page).to have_text("Welcome")

    visit "/games"

    expect(page).to have_text(game.name)

    click_on "Show Dice"

    expect(page).to have_text("Dice for #{game.name}")

    click_on "New die"

    expect(page).to have_text("Back to dice")

    fill_in "Name", with: "Die name"
    click_button "Create Die"

    expect(page).to have_text("Die name")

    click_on("Edit this die")

    expect(page).to have_text("Back to dice")

    fill_in "Name", with: "New name for die"
    click_button "Update Die"

    expect(page).to have_text("New name for die")
    expect(page).not_to have_text("Die name")

    click_button "Destroy this die"

    expect(page).to have_text("Dice for #{game.name}")
  end
end
