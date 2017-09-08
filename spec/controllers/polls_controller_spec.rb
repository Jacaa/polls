require 'rails_helper'

RSpec.describe PollsController do

  describe "GET #show" do
    
    before(:each) do
      @poll = FactoryGirl.create(:poll)
      @id = @poll.id
    end

    it "returns http success" do
      get :show, params: { id: @id }
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get :show, params: { id: @id }
      expect(response).to render_template(:show)
    end
  end
  
  describe "GET #edit" do

    before(:each) do
      @poll = FactoryGirl.create(:poll)
      @id = @poll.id
    end

    it "returns http success" do
      get :edit, params: { id: @id }
      expect(response).to have_http_status(:success)
    end

    it "renders the edit template" do
      get :edit, params: { id: @id }
      expect(response).to render_template(:edit)
    end

    it "assigns @poll variable" do
      get :edit, params: { id: @id }
      expect(assigns(:poll)).to eql(@poll)
    end
  end

  describe "POST #create" do

    context "with valid attribute" do
      it "saves a new poll" do
        expect{
          post :create, params: { poll: FactoryGirl.attributes_for(:poll) }
        }.to change(Poll, :count).by(1)
      end

      it "redirects to the poll edit page - voting" do
        post :create, params: { poll: FactoryGirl.attributes_for(:poll) }
        expect(response).to redirect_to edit_poll_path(assigns(:poll))
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

  describe "PATCH #update" do

    before(:each) do
      @poll = FactoryGirl.create(:poll)
      @id = @poll.id
    end

    context "with one answer chosen" do
      it "changes the database record" do
        answer = "blue"
        patch :update, params: { id: @id, poll: { answers: answer } }
        expect(assigns(:poll).answers_with_values[answer]).to eq(1)
      end
      
      it "redirects to the :show page" do
        answer = "blue"
        patch :update, params: { id: @id, poll: { answers: answer } }
        expect(response).to redirect_to @poll
      end
    end

    context "with no answer chosen" do
      it "doesn't change database record" do
        answer = ""
        patch :update, params: { id: @id, poll: { answers: answer } }, xhr: true
        updated = assigns(:poll)
        expect(updated.answers_with_values).to eq(@poll.answers_with_values)
      end

      it "renders the :update (errors) template" do
        answer = ""
        patch :update, params: { id: @id, poll: { answers: answer } }, xhr: true
        expect(response).to render_template :update
      end
    end
  end
end
