require "rails_helper"

RSpec.describe Resource do
  describe "#sync_resources" do
    it "syncs a newly created resource to the currently active rooms" do
      user = create :user
      game = create :game
      room = create :room, game: game
      room.users << user

      resource = create :resource, game: game

      player = UserRoom.find_by user: user, room: room
      expect(
        player.current_resources.first.resource.name
      ).to eq resource.name
    end
  end
end
