require "rails_helper"

RSpec.describe "joining a room" do
  let(:room) { create :room }
  let(:user) { create :user }

  before do
    sign_in user
  end

  describe "#find_room" do
    it "shows a confirmation page" do
      get find_room_path(room.join_code)

      expect(response.body).to include("Join room #{room.name} playing #{room.game.name}?")
    end
  end

  describe "#join_room" do
    it "adds the user to the room" do
      post join_room_path(room.join_code)

      expect(Room.find(room.id).users).to include user
    end
  end
end
