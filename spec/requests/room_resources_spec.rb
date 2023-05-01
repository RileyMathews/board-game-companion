require "rails_helper"

RSpec.describe "room resources" do
  let(:room_resource) { create :room_resource }

  before do
    sign_in room_resource.user
  end

  describe "#update" do
    it "updates the amount of resource" do
      patch room_resource_path(room_resource.id), params: { room_resource: { amount: 2 } }

      expect(RoomResource.find(room_resource.id).amount).to eq 2
    end
  end

  describe "#group_name" do
    it "delegates to the resource 'group_name' method" do
      expect(room_resource.group_name).to eq room_resource.resource.group_name
    end
  end
end
