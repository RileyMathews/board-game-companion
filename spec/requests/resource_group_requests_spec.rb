require "rails_helper"

RSpec.describe "resource group management" do
  let(:user) { create :user }
  let(:game) { create :game, created_by: user }
  let!(:resource_group) { create :resource_group, game: game }

  before do
    sign_in user
  end

  describe "#index" do
    it "shows all of the groups for a game" do
      get game_resource_groups_path(game)

      expect(response).to render_template :index
      expect(response.body).to include("Resource groups for #{game.name}")
      expect(response.body).to include(resource_group.name)
    end
  end

  describe "#new" do
    it "renders the create form" do
      get new_game_resource_group_path(game)

      expect(response).to render_template :new
      expect(response.body).to include("New group")
      expect(response.body).to include("Create Resource group")
    end
  end

  describe "#create" do
    it "creates a new resource group" do
      post game_resource_groups_path(game), params: { resource_group: { name: "New group name" } }

      expect(response).to redirect_to game_resource_groups_path(game)
      follow_redirect!

      expect(response).to render_template :index
      expect(response.body).to include("New group name")

      group = ResourceGroup.last
      expect(group.name).to eq "New group name"
      expect(group.game).to eq game
    end
  end

  describe "#edit" do
    it "shows the edit form" do
      get edit_resource_group_path(resource_group)

      expect(response).to render_template :edit
      expect(response.body).to include("Editing resource group")
      expect(response.body).to include("Update Resource group")
    end
  end

  describe "#update" do
    let(:resource_group) { create :resource_group, name: "Old name", game: game }

    it "updates the resource group" do
      patch resource_group_path(resource_group), params: { resource_group: { name: "New name" } }

      expect(response).to redirect_to game_resource_groups_path(game)
      follow_redirect!

      expect(response).to render_template :index
      expect(response.body).not_to include("Old name")
      expect(response.body).to include("New name")
    end
  end

  describe "#delete" do
    it "deletes the group" do
      delete resource_group_path(resource_group)

      expect(response).to redirect_to game_resource_groups_path(game)
      follow_redirect!

      expect(response).to render_template :index
      expect(response.body).not_to include(resource_group.name)
    end
  end
end
