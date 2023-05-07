require "rails_helper"

RSpec.describe "room resources" do
  describe "#increment" do
    it "increments the amount of resource" do
      room_resource = create :room_resource
      sign_in room_resource.user

      post increment_room_resource_path(room_resource.id)

      expect(RoomResource.find(room_resource.id).amount).to eq(1)
    end
  end

  describe "#decrement" do
    it "decrements the amount of resource" do
      room_resource = create :room_resource
      sign_in room_resource.user

      post decrement_room_resource_path(room_resource.id)

      expect(RoomResource.find(room_resource.id).amount).to eq(-1)
    end
  end
end
