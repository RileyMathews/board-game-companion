require "rails_helper"

RSpec.describe "room resources" do
  describe "#index" do
    it "displays resources" do
      room_resource = create :room_resource
      room_resource.room.users << room_resource.user
      sign_in room_resource.user

      get room_room_resources_path(room_resource.room.id)

      expect(response.body).to include room_resource.resource.name
    end
  end

  describe "#edit" do
    it "shows the edit form" do
      room_resource = create :room_resource
      room_resource.room.users << room_resource.user
      sign_in room_resource.user

      get edit_room_resource_path(room_resource.id)

      expect(response.body).to include room_resource.resource.name
      expect(response.body).to include "Amount"
      expect(response.body).to include "Save"
    end
  end

  describe "#update" do
    it "updates the amount of the resource" do
      room_resource = create :room_resource
      room_resource.room.users << room_resource.user
      sign_in room_resource.user

      patch room_resource_path(room_resource), params: { room_resource: { amount: 2 } }

      expect(room_resource.reload.amount).to eq 2
    end
  end
end
