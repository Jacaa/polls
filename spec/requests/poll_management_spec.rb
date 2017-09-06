require "rails_helper"

RSpec.describe "Poll management" do
  
  context "create a new Poll" do
    it "with valid attributes redirects to the Poll's page" do
      get "/"
      expect(response).to render_template(:index)
      post "/polls", params: { poll: FactoryGirl.attributes_for(:poll) }
      expect(response).to redirect_to assigns(:poll)
      follow_redirect!
      expect(response).to render_template(:show)
      expect(response.body).to include("Poll was successfully created.")
    end

    it "with invalid attributes displays errors" do
      get "/"
      expect(response).to render_template(:index)
      params = { poll: FactoryGirl.attributes_for(:invalid_poll) }
      post "/polls", params: params, xhr: true
      expect(response).to render_template(:create)
      expect(response.body).to include("At least two possible answers are required")
    end
  end
end