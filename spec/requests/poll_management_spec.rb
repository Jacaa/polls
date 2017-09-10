require "rails_helper"

RSpec.describe "Poll management" do
  
  context "create a new Poll" do
    it "with valid attributes redirects to the Poll's page" do
      get "/"
      expect(response).to render_template(:index)
      post "/", params: { poll: FactoryGirl.attributes_for(:poll) }
      expect(response).to redirect_to voting_path(assigns(:poll))
      follow_redirect!
      expect(response).to render_template(:edit)
      text = "Poll was successfully created."
      expect(response.body).to include(text)
    end

    it "with invalid attributes displays errors" do
      get "/"
      expect(response).to render_template(:index)
      params = { poll: FactoryGirl.attributes_for(:invalid_poll) }
      post "/", params: params, xhr: true
      expect(response).to render_template(partial: "_errors")
      text = "At least two different answers are required"
      expect(response.body).to include(text)
    end
  end

  context "voting (edit created Poll)" do
    
    before(:each) do
      @poll = FactoryGirl.create(:poll)
    end

    it "with one answer chosen" do
      get "/#{@poll.id}/voting"
      expect(response).to render_template(:edit)
      patch "/#{@poll.id}/voting", params: { poll: { answers: "blue" } }
      expect(response).to redirect_to results_path(@poll)
      follow_redirect!
      expect(response).to render_template(:show)
      expect(response.body).to include("Results")
    end

    it "with no answer chosen" do
      get "/#{@poll.id}/voting"
      expect(response).to render_template(:edit)
      patch "/#{@poll.id}/voting", params: { poll: { answers: "" } }, xhr: true
      expect(response).to render_template(partial: "_errors")
      text = "You need to choose an answer"
      expect(response.body).to include(text)
    end
  end
end