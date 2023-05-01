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
end
