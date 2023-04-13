require "rails_helper"

RSpec.describe "room resources" do
  let(:room_resource) { create :room_resource }

  before do
    sign_in room_resource.user
  end

  describe "#update" do
    it "updates the ammount of resource" do
      patch room_resource_path(room_resource.id), params: { room_resource: { ammount: 2 } }

      expect(RoomResource.find(room_resource.id).ammount).to eq 2
    end
  end
end
