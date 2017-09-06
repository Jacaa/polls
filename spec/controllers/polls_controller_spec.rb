require 'rails_helper'

RSpec.describe PollsController do

  describe "GET #show" do
    
    before(:each) do
      @poll = FactoryGirl.create(:poll)
    end

    it "returns http success" do
      get :show, params: { id: @poll.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get :show, params: { id: @poll.id }
      expect(response).to render_template(:show)
    end
  end

  describe "POST #create" do

    context "with valid attribute" do
      it "saves a new poll" do
        expect{
          post :create, params: { poll: FactoryGirl.attributes_for(:poll) }
        }.to change(Poll, :count).by(1)
      end

      it "redirects to the poll" do
        post :create, params: { poll: FactoryGirl.attributes_for(:poll) }
        expect(response).to redirect_to assigns(:poll)
      end
    end

    context "with invalid attribute" do
      it "doesn't save a new poll" do
        params = { poll: FactoryGirl.attributes_for(:invalid_poll) }
        expect{
          post :create, params: params, xhr: true
        }.to_not change(Poll, :count)
      end
      
      it "renders the :create (errors) template" do
        params = { poll: FactoryGirl.attributes_for(:invalid_poll) }
        post :create, params: params, xhr: true
        expect(response).to render_template(:create)
      end
    end
  end
end
