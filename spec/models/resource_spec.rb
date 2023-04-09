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

  describe "group_name" do
    it "returns 'Ungrouped' when not part of a group" do
      expect(create(:resource, resource_group: nil).group_name).to eq "Ungrouped"
    end

    it "returns the name of the group when the resource has one" do
      resource = create :resource
      expect(resource.group_name).to eq resource.resource_group.name
    end
  end
end
