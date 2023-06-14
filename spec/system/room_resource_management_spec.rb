require "rails_helper"

RSpec.describe "room resource management" do
  it "can manage the amount of resource a player has" do
    user = login_user
    game = create :game, created_by: user
    resource = create :resource, game: game
    room = create :room, game: game, created_by: user

    visit room_room_resources_path(room)

    expect(page).to have_text("#{resource.name}: 0")

    click_link resource.name
    fill_in "New Value", with: 2
    click_button "Save"

    expect(page).to have_text("#{resource.name}: 2")
  end
end
