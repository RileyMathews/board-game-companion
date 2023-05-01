require "rails_helper"

RSpec.describe UserRoom do
  subject { create :user_room }

  describe "associations" do
    it { is_expected.to belong_to :room }
    it { is_expected.to belong_to :user }
  end

  describe "validations" do
    it { is_expected.to validate_uniqueness_of(:user).scoped_to(:room_id) }
  end

  describe "#sync_resources" do
    it "creates a user room resource for every game resource" do
      user = create :user
      game = create :game
      resource = create :resource, game: game
      room = create :room, game: game

      room.users << user

      user_room = described_class.find_by(room: room, user: user)

      expect(
        user_room.room_resources.first.resource.name
      ).to eq resource.name
    end
  end

  describe "#resourecs_by_group" do
    it "returns a map of resources by their group name" do
      user_room = create :user_room
      resource_group_one = create :resource_group, game: user_room.room.game
      resource_group_two = create :resource_group, game: user_room.room.game
      [resource_group_one, resource_group_two].each do |group|
        create_list :resource, 3, resource_group: group, game: user_room.room.game
      end
      create_list :resource, 2, resource_group: nil, game: user_room.room.game

      result = user_room.resources_by_group

      expect(result[resource_group_one.name].length).to eq 3
      expect(result[resource_group_two.name].length).to eq 3
      expect(result["Ungrouped"].length).to eq 2
      expect(result[resource_group_one.name].first).to be_a RoomResource
    end
  end
end
