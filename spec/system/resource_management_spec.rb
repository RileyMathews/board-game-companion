require "rails_helper"

RSpec.describe "resource management" do
  it "can manage the various aspects of resuources" do
    user = login_user
    game = create :game, created_by: user

    expect(page).to have_text("Welcome")

    visit games_path

    expect(page).to have_text(game.name)

    click_on "Resources"

    expect(page).to have_text("Resources for #{game.name}")

    click_on "New resource"

    expect(page).to have_text("Back to resources")

    fill_in "Name", with: "Resource name"
    fill_in "Min", with: 10
    fill_in "Max", with: 20
    click_button "Save"

    expect(page).to have_text("Resource name")
    expect(page).to have_text("10")
    expect(page).to have_text("20")

    click_on("Edit this resource")

    expect(page).to have_text("Back to resources")

    fill_in "Name", with: "New name for resource"
    fill_in "Min", with: 5
    fill_in "Max", with: 25
    click_button "Save"

    expect(page).to have_text("New name for resource")
    expect(page).to have_text("5")
    expect(page).to have_text("25")
    expect(page).not_to have_text("Resource name")

    click_button "Delete"

    expect(page).to have_text("Resources for #{game.name}")
    expect(page).not_to have_text("New name for resource")
  end
end
