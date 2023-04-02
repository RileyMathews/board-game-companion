require "rails_helper"

RSpec.describe RollLog do
  describe "#summary" do
    it "loads the most recent rolls data" do
      user = User.create!(email: "test@test.com", password: "Password1@", username: "Testname", confirmed_at: DateTime.now)
      game = Game.create!(name: "Skyrim", created_by: user)
      room = Room.create!(name: "weekly game night", game: game, created_by: user)
      die1 = Die.create!(game:game, name: "Die 1")
      die2 = Die.create!(game:game, name: "Die 2")
      die1_face1 = Face.create!(die: die1, name: "Die 1 face 1")
      die1_face2 = Face.create!(die: die1, name: "Die 1 face 2")
      die2_face1 = Face.create!(die: die2, name: "Die 2 face 1")
      die2_face2 = Face.create!(die: die2, name: "Die 2 face 2")
      log = described_class.create!(user: User.first, room: room)
      RollResult.create!(roll_log: log, face: die1_face1)
      RollResult.create!(roll_log: log, face: die1_face2)
      RollResult.create!(roll_log: log, face: die2_face1)
      RollResult.create!(roll_log: log, face: die2_face2)
      RollResult.create!(roll_log: log, face: die2_face2)

      # archived results
      RollResult.create!(roll_log: log, face: die1_face1, archived: true)

      summary = log.summary
      expect(summary[die1_face1.name]).to eq 1
      expect(summary[die1_face2.name]).to eq 1
      expect(summary[die2_face1.name]).to eq 1
      expect(summary[die2_face2.name]).to eq 2
    end
  end
end
