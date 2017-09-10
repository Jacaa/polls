require 'rails_helper'

RSpec.describe "Routes" do
  
  describe "for Home controller" do
    it "GET '/' routes to the index action" do
      expect(get("/")).to route_to("home#index")
    end
  end

  describe "for Poll controller" do

    it "GET '/:id/results' routes to the poll show action" do
      expect(get("/1/results")).to route_to(
        controller: "polls",
        action: "show",
        id: "1"
      )
    end

    it "GET '/:id/voting' routes to the poll edit action" do
      expect(get("/1/voting")).to route_to(
        controller: "polls",
        action: "edit",
        id: "1"
      )
    end

    it "PATCH '/:id/voting' routes to the poll update action" do
      expect(patch("/1/voting")).to route_to(
        controller: "polls",
        action: "update",
        id: "1"
      )
    end

    it "POST '/' routes to the poll create action" do
      expect(post("/")).to route_to(
        controller: "polls",
        action: "create"
      )
    end
  end
end