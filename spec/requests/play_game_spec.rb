require "rails_helper"

RSpec.describe "playing a game" do
  let(:room) { create :room }
  let(:user) { create :user }

  before do
    room.users << user
    sign_in user
  end

  describe "#archive_roll" do
    it "archives the roll" do
      roll = create :roll, user: user, room: room

      post archive_roll_path(roll.id)

      expect(response).to redirect_to room_play_path(roll.room)
      expect(Roll.find(roll.id).archived).to be true
    end
  end
end
