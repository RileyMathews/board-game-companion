require "rails_helper"

RSpec.describe "playing a game" do
  let!(:room) { create :room }
  let!(:die) { create :die, game: room.game }
  let!(:face) { create :face, die: die }
  let!(:resource) { create :resource, game: room.game }

  it "allows the player to play a game once they have joined" do
    user = room.created_by
    visit "/users/sign_in"
    fill_in "Email", with: user.email
    fill_in "Password", with: "Password1@"
    click_button "Log In"

    expect(page).to have_text("Welcome")

    visit room_play_path(room)

    expect(page).to have_text("Playing #{room.game.name}")
    expect(page).to have_text("#{resource.name}: 0")
    expect(page).to have_text(die.name)

    click_on "+1"

    expect(page).to have_text("#{resource.name}: 1")

    click_on "-1"

    expect(page).to have_text("#{resource.name}: 0")

    click_on "5"

    expect(page).to have_text(face.name)
    expect(page).to have_text("#{face.name}: 5")
  end
end
