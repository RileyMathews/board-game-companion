require "rails_helper"

RSpec.describe "room resources" do
  let(:room_resource) { create :user_room_resource }

  before do
    sign_in user_room_resource.user
  end

  describe "#update" do
    it "updates the ammount of resource" do
      patch room_resource_path(user_room_resource.id), params: { user_room_resource: { ammount: 2 } }

      expect(RoomResource.find(user_room_resource.id).ammount).to eq 2
    end
  end
end
