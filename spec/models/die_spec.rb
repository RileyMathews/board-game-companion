require "rails_helper"

RSpec.describe Die do
  subject(:die) { create :die }

  let(:user) { create :user }
  let(:room) { create :room }
  let!(:face) { create :face, die: die }

  describe "associations" do
    it { is_expected.to belong_to :game }
    it { is_expected.to have_many :faces }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:game_id) }
  end

  describe "#roll" do
    it "creates a roll and roll results for the given roll log" do
      die.roll user: user, room: room, number: 3

      roll = Roll.last
      results = roll.roll_results
      expect(results.length).to be 3
      results.each do |result|
        expect(result.face.name).to eq face.name
      end
    end
  end
end
