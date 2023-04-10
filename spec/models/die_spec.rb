require "rails_helper"

RSpec.describe Die do
  let(:die) { create :die }
  let(:roll_log) { create :roll_log }
  let!(:face) { create :face, die: die }

  describe "#roll" do
    it "creates a roll and roll results for the given roll log" do
      die.roll roll_log: roll_log, number: 3

      roll = roll_log.rolls.last
      results = roll.roll_results
      expect(results.length).to be 3
      results.each do |result|
        expect(result.face.name).to eq face.name
      end
    end
  end
end
