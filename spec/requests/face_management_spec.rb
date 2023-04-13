require "rails_helper"

RSpec.describe "face management" do
  let(:game) { create :game }
  let(:user) { game.created_by }
  let(:die) { create :die, game: game }
  let(:face) { create :face, die: die }

  before do
    sign_in user
  end

  describe "#index" do
    it "shows a list of all faces for a given die" do
      get die_faces_path(die)

      expect(response.body).to include("Faces for #{die.name}")
      expect(response.body).to have_link("New face", href: new_die_face_path(die))
    end
  end

  describe "#new" do
    it "shows the form for a new face" do
      get new_die_face_path(die)

      expect(response.body).to include("New face")
      expect(response.body).to include("Save")
    end
  end

  describe "#edit" do
    it "shows the edit form" do
      get edit_face_path(face)

      expect(response.body).to include("Editing face")
    end
  end

  describe "#create" do
    it "creates a new face" do
      post die_faces_path(die), params: { face: { name: "New face" } }

      expect(Face.last.name).to eq "New face"
    end
  end

  describe "#update" do
    it "updates the name of the face" do
      patch face_path(face), params: { face: { name: "Updated name" } }

      expect(Face.find(face.id).name).to eq "Updated name"
    end
  end

  describe "#destroy" do
    it "destroys the dice" do
      delete face_path(face)

      expect(Face.exists?(face.id)).to be false
    end
  end
end
