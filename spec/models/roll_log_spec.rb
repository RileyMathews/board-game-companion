require "rails_helper"

RSpec.describe RollLog do
  let(:log) { create :roll_log }
  let(:die) { create :die, game: log.user_room.room.game }
  let!(:face) { create :face, die: die }

  describe "#summary" do
    it "pulls all unarchived roll results and groups them by face" do
      3.times do
        die.roll roll_log: log, number: 3
      end

      RollResult.all.update(archived: true)

      3.times do
        die.roll roll_log: log, number: 3
      end

      result = log.summary

      expect(result.length).to eq 1
      expect(result[face.name]).to eq 9
    end
  end
end
