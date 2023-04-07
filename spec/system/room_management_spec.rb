require "rails_helper"

RSpec.describe "room management" do
  let(:user) { create :user, password: "Password1@" }
  let!(:game) { create :game, created_by: user }

  before do
    visit "/users/sign_in"
    fill_in "Email", with: user.email
    fill_in "Password", with: "Password1@"
    click_button "Log In"
  end

  it "can manage the various aspects of rooms" do
    visit "/"
    click_on "Games"

    expect(page).to have_text(game.name)

    click_on "Rooms"

    expect(page).to have_text("Rooms for #{game.name}")

    click_on "New room"

    expect(page).to have_text("Back to rooms")

    fill_in "Name", with: "Room name"
    click_button "Create Room"

    expect(page).to have_text("Room name")

    click_on("Edit this room")

    expect(page).to have_text("Back to rooms")

    fill_in "Name", with: "New name for room"
    click_button "Update Room"

    expect(page).to have_text("New name for room")
    expect(page).not_to have_text("Room name")

    click_button "Destroy this room"

    expect(page).to have_text("Rooms for #{game.name}")
    expect(page).not_to have_text("New name for room")
  end

  it "allows the user that created a room to play in a room" do
    visit "/"
    click_on "Games"
    click_on "Rooms"
    click_on "New room"
    fill_in "Name", with: "Room name"
    click_button "Create Room"
    visit "/"
    click_on "Play!"

    expect(page).to have_text("Playing #{game.name}")
  end

  it "allows a second user to join a game" do
    room = create :room
    join_code = room.join_code

    visit join_room_path(join_code)

    expect(page).to have_text("Join room #{room.name} playing #{room.game.name}?")

    click_button "confirm"

    expect(page).to have_text("Playing #{room.game.name}")
  end
end
