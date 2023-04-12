require "rails_helper"

RSpec.describe "user room resources" do
  let(:user_room_resource) { create :user_room_resource }

  before do
    sign_in user_room_resource.user_room.user
  end

  describe "#update" do
    it "updates the ammount of resource" do
      patch user_room_resource_path(user_room_resource.id), params: { user_room_resource: { ammount: 2 } }

      expect(UserRoomResource.find(user_room_resource.id).ammount).to eq 2
    end
  end
end
