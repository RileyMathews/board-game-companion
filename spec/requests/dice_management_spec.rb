require "rails_helper"

RSpec.describe "dice management" do
  let(:game) { create :game }
  let(:user) { game.created_by }
  let(:die) { create :die, game: game }

  before do
    sign_in user
  end

  describe "#index" do
    it "shows a list of all dice for a given game" do
      get game_dice_path(game)

      expect(response.body).to include("Dice for #{game.name}")
      expect(response.body).to have_link("New die", href: new_game_die_path(game))
    end
  end

  describe "#new" do
    it "shows the form for a new die" do
      get new_game_die_path(game)

      expect(response.body).to include("New die")
      expect(response.body).to include("Save")
    end
  end

  describe "#edit" do
    it "shows the edit form" do
      get edit_die_path(die)

      expect(response.body).to include("Editing die")
    end
  end

  describe "#create" do
    it "creates a new die" do
      post game_dice_path(game), params: { die: { name: "New Die" } }

      expect(Die.last.name).to eq "New Die"
    end
  end

  describe "#update" do
    it "updates the name of the die" do
      patch die_path(die), params: { die: { name: "Updated name" } }

      expect(Die.find(die.id).name).to eq "Updated name"
    end
  end

  describe "#destroy" do
    it "destroys the dice" do
      delete die_path(die)

      expect(Die.exists?(die.id)).to be false
    end
  end
end
