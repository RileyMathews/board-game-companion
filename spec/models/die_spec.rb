require "rails_helper"

RSpec.describe Die do
  let(:die) { create(:die) }
  let!(:face) { create(:face, die: die) }

  describe "#roll" do
    it "rolls one die by default" do
      result = die.roll

      expect(result.length).to eq 1
      expect(result.first.name).to eq face.name
    end

    it "rolls the number passed in" do
      result = die.roll number: 5

      expect(result.length).to eq 5
      result.each do |rolled_face|
        expect(rolled_face.name).to eq face.name
      end
    end

    describe "rolling a die with multiple faces" do
      let(:d2) { create(:die) }
      let!(:face1) { create(:face, die: d2) }
      let!(:face2) { create(:face, die: d2) }

      it "is able to roll multiple sides" do
        results = d2.roll number: 20

        face_1_rolled = results.any? { |r| r.name == face1.name }
        face_2_rolled = results.any? { |r| r.name == face2.name }
        expect(face_1_rolled).to be true
        expect(face_2_rolled).to be true
      end
    end
  end
end
