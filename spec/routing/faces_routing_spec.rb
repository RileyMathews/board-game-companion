require "rails_helper"

RSpec.describe FacesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/faces").to route_to("faces#index")
    end

    it "routes to #new" do
      expect(get: "/faces/new").to route_to("faces#new")
    end

    it "routes to #show" do
      expect(get: "/faces/1").to route_to("faces#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/faces/1/edit").to route_to("faces#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/faces").to route_to("faces#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/faces/1").to route_to("faces#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/faces/1").to route_to("faces#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/faces/1").to route_to("faces#destroy", id: "1")
    end
  end
end
