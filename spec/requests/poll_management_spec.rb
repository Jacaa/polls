require "rails_helper"

RSpec.describe "Poll management" do
  
  context "create a new Poll" do
    it "with valid attributes redirects to the Poll's page" do
      get "/"
      expect(response).to render_template(:index)
      post "/", params: { poll: FactoryGirl.attributes_for(:poll) }
      poll = assigns(:poll)
      expect(response).to redirect_to voting_path(poll)
      follow_redirect!
      expect(response).to render_template(:edit)
      # Changes in DB
      expect(poll.question).to eq("What's your favourite color?")
      expect(poll.answers).to eq([ "blue", "green" ])
      expect(poll.allow_multiple).to eq(false)
      expect(poll.allow_duplication).to eq(false)
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

  context "voting" do
    
    before(:each) do
      @poll = FactoryGirl.create(:poll)
    end

    it "with one answer chosen" do
      get "/#{@poll.id}/voting"
      expect(response).to render_template(:edit)
      answer = "blue"
      patch "/#{@poll.id}/voting", params: { poll: { answers: answer } }
      expect(response).to redirect_to results_path(assigns(:poll))
      follow_redirect!
      expect(response).to render_template(:show)
      # Changes in DB
      expect(assigns(:poll).answers_with_values[answer]).to eq(1)
      expect(assigns(:poll).list_of_ip).to eq([request.remote_ip])
      # Try to vote again
      get "/#{@poll.id}/voting"
      patch "/#{@poll.id}/voting", params: { poll: { answers: answer } }
      expect(response).to render_template(partial: "_errors")
      expect(response.body).to include("You have already voted!")
      # No changes in DB
      expect(assigns(:poll).answers_with_values[answer]).to eq(1)
    end

    it "with no answer chosen" do
      get "/#{@poll.id}/voting"
      expect(response).to render_template(:edit)
      patch "/#{@poll.id}/voting", params: { poll: { answers: "" } }, xhr: true
      expect(response).to render_template(partial: "_errors")
      expect(response.body).to include("You need to choose an answer")
    end

    it "with multiple answers chosen" do
      answers = [ "blue", "green" ]
      poll = FactoryGirl.create(:poll_allow_multiple)
      get "/#{poll.id}/voting"
      expect(response).to render_template(:edit)
      patch "/#{poll.id}/voting", params: { poll: { answers: answers } }
      expect(response).to redirect_to results_path(assigns(:poll))
      follow_redirect!
      expect(response).to render_template(:show)
      # Changes in DB
      answers.each do |answer|
        expect(assigns(:poll).answers_with_values[answer]).to eq(1)
      end
    end

    it "with allowing duplication" do
      poll = FactoryGirl.create(:poll_allow_duplication)
      answer = "blue"
      (1..5).to_a.each do |i|
        get "/#{poll.id}/voting"
        expect(response).to render_template(:edit)
        patch "/#{poll.id}/voting", params: { poll: { answers: answer } }
        expect(response).to redirect_to results_path(assigns(:poll))
        follow_redirect!
        expect(response).to render_template(:show)
        # Changes in DB
        expect(assigns(:poll).answers_with_values[answer]).to eq(i)
        expect(assigns(:poll).list_of_ip.size).to eq(0)
      end
    end
  end
end