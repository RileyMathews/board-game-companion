require "rails_helper"

RSpec.describe RollLog do
  let(:log) { create :roll_log }
  let(:die1) { create :die, game: log.room.game }
  let(:die2) { create :die, game: log.room.game }
  let(:face1) { create :face, die: die1 }
  let(:face2) { create :face, die: die1 }
  let(:face3) { create :face, die: die2 }
  let(:face4) { create :face, die: die2 }

  describe "#summary" do
    it "loads the most recent roll data" do
      create :roll_result, face: face1, roll_log: log
      create :roll_result, face: face2, roll_log: log
      create :roll_result, face: face3, roll_log: log
      create :roll_result, face: face4, roll_log: log

      summary = log.summary

      expect(summary[face1.name]).to eq 1
      expect(summary[face2.name]).to eq 1
      expect(summary[face3.name]).to eq 1
      expect(summary[face4.name]).to eq 1
    end

    it "only show results for the log" do
      second_log = create :roll_log
      create :roll_result, face: face1, roll_log: second_log
      create :roll_result, face: face2, roll_log: log

      summary = second_log.summary

      expect(summary.length).to eq 1
    end
  end
end
