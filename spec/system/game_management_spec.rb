require "rails_helper"

RSpec.describe "game management" do
  it "can manage the various aspects of a game" do
    user = login_user

    visit "/"

    expect(page).to have_text("Welcome to board game companion!")

    click_on "Games"

    expect(page).to have_text("New game")

    click_on "New game"

    expect(page).to have_text("Back to games")

    fill_in "Name", with: "Game name"
    click_button "Save"

    expect(page).to have_text("Game name")

    click_on "Edit this game"

    expect(page).to have_text("Back to games")

    fill_in "Name", with: "New name for game"
    click_button "Save"

    expect(page).to have_text("New name for game")
    expect(page).not_to have_text("Game name")

    click_button "Delete"

    expect(page).not_to have_text("New name for game")
  end
end
