require "rails_helper"

RSpec.describe "face management" do
  let(:user) { create :user }
  let!(:room) { create :room, created_by: user }
  let(:joined_room) { create :room }

  before do
    sign_in user
  end

  describe "#index" do
    it "shows a list of all rooms the user is in" do
      joined_room.users << user

      get "/"

      expect(response.body).to include(room.name)
      expect(response.body).to include(joined_room.name)
    end
  end
end
