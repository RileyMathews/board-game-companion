require "rails_helper"

RSpec.describe "resource management" do
  let(:user) { create :user }
  let(:game) { create :game, created_by: user }
  let!(:resource_group) { create :resource_group, game: game }
  let!(:resource_group2) { create :resource_group, game: game }

  before do
    sign_in user
  end

  describe "#new" do
    it "shows a form with resource group options" do
      get new_game_resource_path(game)

      game.resource_groups.each do |group|
        expect(response.body).to include("<option value=\"#{group.id}\">#{group.name}</option>")
      end
      expect(response.body).to include('<option selected="selected" value="">------</option>')
    end
  end

  describe "#edit" do
    let(:resource) { create :resource, game: game }

    it "shows a form with resource group options" do
      get edit_resource_path(resource)

      game.resource_groups.each do |group|
        expect(response.body).to include("<option value=\"#{group.id}\">#{group.name}</option>")
      end
    end
  end

  describe "#create" do
    it "creates a new resource" do
      post game_resources_path(game),
           params: { resource: { name: "gold", min: 0, max: 1000, resource_group_id: resource_group.id } }

      resource = Resource.last

      expect(resource.name).to eq "gold"
      expect(resource.min).to eq 0
      expect(resource.max).to eq 1000
      expect(resource.resource_group_id).to eq resource_group.id
    end
  end
end
