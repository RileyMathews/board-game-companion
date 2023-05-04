require "rails_helper"

RSpec.describe "die management" do
  it "can manage the various aspects of dice" do
    user = login_user
    game = create :game, created_by: user

    expect(page).to have_text("Welcome")

    visit "/games"

    expect(page).to have_text(game.name)

    click_on "Dice"

    expect(page).to have_text("Dice for #{game.name}")

    click_on "New die"

    expect(page).to have_text("Back to dice")

    fill_in "Name", with: "Die name"
    click_button "Save"

    expect(page).to have_text("Die name")

    click_on("Edit this die")

    expect(page).to have_text("Back to dice")

    fill_in "Name", with: "New name for die"
    click_button "Save"

    expect(page).to have_text("New name for die")
    expect(page).not_to have_text("Die name")

    click_button "Delete"

    expect(page).to have_text("Dice for #{game.name}")
    expect(page).not_to have_text("New name for die")
  end
end
