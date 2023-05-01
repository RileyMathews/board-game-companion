require "rails_helper"

RSpec.describe Room do
  subject { create :room }

  describe "associations" do
    it { is_expected.to belong_to :game }
    it { is_expected.to belong_to(:created_by).class_name("User") }
    it { is_expected.to have_many :user_rooms }
    it { is_expected.to have_many :users }
    it { is_expected.to have_many :room_resources }
    it { is_expected.to have_many :resources }
    it { is_expected.to have_many :rolls }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:created_by_id) }
  end

  describe "after_create callback" do
    it "adds the creating user to the list of players" do
      room = create :room

      expect(room.users).to include room.created_by
    end

    it "creates room resource entries for global resources of the game" do
      game = create :game
      global_resource = create :resource, game: game, global: true
      create :resource, game: game, global: false

      room = create :room, game: game

      global_room_resources = RoomResource.where(user: nil, room: room)
      expect(global_room_resources.length).to be 1
      expect(global_room_resources.first.resource).to eq global_resource
    end

    it "creates room resource entries for the creating player" do
      game = create :game
      non_global_resource = create :resource, game: game, global: false

      room = create :room, game: game

      player_resources = RoomResource.where(user: room.created_by, room: room)
      expect(player_resources.length).to be 1
      expect(player_resources.first.resource).to eq non_global_resource
    end
  end

  describe "grouped_resources_for_player" do
    it "returns a nested hash of global and player resources grouped by resource grouping" do
      game = create :game
      resource_group1 = create :resource_group, game: game
      resource_group2 = create :resource_group, game: game
      global_resource_group1 = create :resource_group, game: game
      global_resource_group2 = create :resource_group, game: game
      [resource_group1, resource_group2].each do |group|
        create_list :resource, 5, game: game, resource_group: group
      end
      [global_resource_group1, global_resource_group2].each do |group|
        create_list :resource, 5, game: game, global: true, resource_group: group
      end

      room = create :room, game: game

      result = room.grouped_resources_for_player user: room.created_by

      expect(result[:global].length).to eq 2
      expect(result[:player].length).to eq 2
      expect(result[:global][global_resource_group1.name].length).to eq 5
      expect(result[:global][global_resource_group2.name].length).to eq 5
      expect(result[:player][resource_group1.name].length).to eq 5
      expect(result[:player][resource_group2.name].length).to eq 5

      non_global_resource = Resource.where(game: game, global: false).first
      expect(result[:player][non_global_resource.resource_group.name].first.amount).to eq 0

      global_resource = Resource.where(game: game, global: true).first
      expect(result[:global][global_resource.resource_group.name].first.amount).to eq 0
    end
  end
end
