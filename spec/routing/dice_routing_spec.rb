require "rails_helper"

RSpec.describe DiceController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/dice").to route_to("dice#index")
    end

    it "routes to #new" do
      expect(get: "/dice/new").to route_to("dice#new")
    end

    it "routes to #show" do
      expect(get: "/dice/1").to route_to("dice#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/dice/1/edit").to route_to("dice#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/dice").to route_to("dice#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/dice/1").to route_to("dice#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/dice/1").to route_to("dice#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/dice/1").to route_to("dice#destroy", id: "1")
    end
  end
end
