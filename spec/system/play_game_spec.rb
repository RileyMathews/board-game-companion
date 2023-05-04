require "rails_helper"

RSpec.describe "playing a game" do
  let!(:room) { create :room }
  let!(:die) { create :die, game: room.game }
  let!(:face) { create :face, die: die }
  let!(:resource) { create :resource, game: room.game }

  it "allows the player to play a game once they have joined" do
    login_user room.created_by

    expect(page).to have_text("Welcome")

    visit room_play_path(room)

    expect(page).to have_text("Playing #{room.game.name}")
    expect(page).to have_text("#{resource.name}: 0")
    expect(page).to have_text(die.name)

    click_button id: "resource-button-#{resource.id}"
    click_on "+1"

    expect(page).to have_text("#{resource.name}: 1")

    click_on "-1"

    expect(page).to have_text("#{resource.name}: 0")
    # click resource again to clear dropdown
    click_button id: "resource-button-#{resource.id}"

    click_button id: "die-button-#{die.id}"
    click_on "5"

    expect(page).to have_text(face.name)
    expect(page).to have_text("#{face.name}: 5")
  end
end
