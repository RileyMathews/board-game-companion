require "rails_helper"

RSpec.describe Resource do
  subject { create :resource }

  describe "associations" do
    it { is_expected.to belong_to :game }
    it { is_expected.to belong_to(:resource_group).optional }
    it { is_expected.to have_many :room_resources }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:game_id) }
  end

  describe "#sync_resources" do
    describe "when a resource is not global" do
      it "syncs a newly created resource to the currently active rooms" do
        user = create :user
        game = create :game
        room = create :room, game: game
        room.users << user

        create :resource, game: game, global: true
        non_global_resource = create :resource, game: game, global: false

        room_resources = RoomResource.where(room: room, user: user)
        expect(room_resources.length).to eq 1
        expect(room_resources.first.resource).to eq non_global_resource
      end
    end

    describe "when a resource is global" do
      it "syncs only as a global resource" do
        game = create :game
        room = create :room, game: game

        create :resource, game: game, global: false
        global_resource = create :resource, game: game, global: true

        room_resources = RoomResource.where(room: room, user: nil)
        expect(room_resources.length).to eq 1
        expect(room_resources.first.resource).to eq global_resource
      end
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
