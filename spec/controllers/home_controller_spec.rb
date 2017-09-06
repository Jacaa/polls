require 'rails_helper'

RSpec.describe HomeController do

  describe "GET #index" do

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assings @poll with two empty answers" do
      get :index
      poll = assigns(:poll)
      expect(poll.answers).to eql(['',''])
      expect(assigns(:poll)).to be_a(Poll)
    end
  end
end
