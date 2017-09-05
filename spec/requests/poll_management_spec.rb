require "rails_helper"

RSpec.describe "Poll management" do
  
  it "creates a new Poll and redirects to the Poll's page" do
    get "/"
    post "/polls", params: { poll: FactoryGirl.attributes_for(:poll) }
    poll = assigns(:poll)
    expect(response).to redirect_to poll
    follow_redirect!
    expect(response).to render_template(:show)
    expect(response.body).to include("Poll was successfully created.")
  end

  it "displays errors after invalid submission" do
    get "/"
    post "/polls", params: { poll: FactoryGirl.attributes_for(:invalid_poll) }
    poll = assigns(:poll)
    expect(poll).to_not be_valid
    expect(response).to render_template(:index)
  end
end