require "rails_helper"

RSpec.describe "face management" do
  let(:game) { create :game }
  let(:user) { game.created_by }

  before do
    sign_in user
  end

  describe "#index" do
    it "shows a list of all games" do
      get games_path

      expect(response.body).to include("games")
      expect(response.body).to include(game.name)
      expect(response.body).to have_link("New game", href: new_game_path)
    end
  end

  describe "#new" do
    it "shows the form for a new game" do
      get new_game_path

      expect(response.body).to include("New game")
      expect(response.body).to include("Save")
    end
  end

  describe "#edit" do
    it "shows the edit form" do
      get edit_game_path(game)

      expect(response.body).to include("Editing game")
    end
  end

  describe "#create" do
    it "creates a new face" do
      post games_path, params: { game: { name: "New game" } }

      expect(Game.last.name).to eq "New game"
    end
  end

  describe "#update" do
    it "updates the name of the face" do
      patch game_path(game), params: { game: { name: "Updated name" } }

      expect(Game.find(game.id).name).to eq "Updated name"
    end
  end

  describe "#destroy" do
    it "destroys the dice" do
      delete game_path(game)

      expect(Game.exists?(game.id)).to be false
    end
  end
end
