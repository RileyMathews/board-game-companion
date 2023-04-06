require "rails_helper"

RSpec.describe UserRoom do
  describe "#sync_resources" do
    it "creates a user room resource for every game resource" do
      user = create :user
      game = create :game
      resource = create :resource, game: game
      room = create :room, game: game

      room.users << user

      player = described_class.find_by user: user, room: room

      expect(
        player.current_resources.first.resource.name
      ).to eq resource.name
    end
  end
end
