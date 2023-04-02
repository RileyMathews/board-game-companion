require "rails_helper"

RSpec.describe RollLog do
  describe "#summary" do
    it "loads the most recent roll data" do
      log = create(:roll_log)
      die1 = create(:die, game: log.room.game)
      die2 = create(:die, game: log.room.game)
      face1 = create(:face, die: die1)
      face2 = create(:face, die: die1)
      face3 = create(:face, die: die2)
      face4 = create(:face, die: die2)
      create(:roll_result, face: face1, roll_log: log)
      create(:roll_result, face: face2, roll_log: log)
      create(:roll_result, face: face3, roll_log: log)
      create(:roll_result, face: face4, roll_log: log)

      summary = log.summary

      expect(summary[face1.name]).to eq 1
      expect(summary[face2.name]).to eq 1
      expect(summary[face3.name]).to eq 1
      expect(summary[face4.name]).to eq 1
    end
  end
end
