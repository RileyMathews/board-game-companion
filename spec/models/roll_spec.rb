require "rails_helper"

RSpec.describe Roll do
  let(:roll) { create :roll }
  let(:die1) { create :die, game: roll.room.game }
  let(:die2) { create :die, game: roll.room.game }
  let(:face1) { create :face, die: die1 }
  let(:face2) { create :face, die: die1 }
  let(:face3) { create :face, die: die2 }
  let(:face4) { create :face, die: die2 }

  describe "#summary" do
    it "returns a map of face names to count" do
      create :roll_result, face: face1, roll: roll
      create :roll_result, face: face2, roll: roll
      create :roll_result, face: face3, roll: roll
      create :roll_result, face: face4, roll: roll

      summary = roll.summary

      expect(summary[face1.name]).to eq 1
      expect(summary[face2.name]).to eq 1
      expect(summary[face3.name]).to eq 1
      expect(summary[face4.name]).to eq 1
    end
  end

  describe "#summary_string" do
    it "returns a string representation of the summary" do
      face_a = create :face, name: "A", die: die1
      face_b = create :face, name: "B", die: die1
      create :roll_result, face: face_a, roll: roll
      create :roll_result, face: face_b, roll: roll

      summary = roll.summary_string

      expected_string = "#{face_a.name}: 1 | #{face_b.name}: 1"
      expect(summary).to eq expected_string
    end
  end
end
