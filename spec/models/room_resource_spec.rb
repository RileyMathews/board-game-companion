require "rails_helper"

RSpec.describe RoomResource do
  subject(:room_resource) { create :room_resource }

  describe "associations" do
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to belong_to :resource }
    it { is_expected.to belong_to :room }
  end

  describe "validations" do
    it { is_expected.to validate_uniqueness_of(:resource).scoped_to(:user_id, :room_id) }
  end

  describe ".other_players" do
    it "returns other players resources for the given room and user" do
      active_user = create :user
      other_user = create :user
      room = create :room
      active_user_resource = create :room_resource, room: room, user: active_user
      other_user_resource = create :room_resource, room: room, user: other_user

      result = described_class.other_players room, active_user

      expect(result).not_to include active_user_resource
      expect(result).to include other_user_resource
    end
  end

  describe "#group_name" do
    it "delegates to the resource 'group_name' method" do
      expect(room_resource.group_name).to eq room_resource.resource.group_name
    end
  end
end
