require 'rails_helper'

RSpec.describe "home/index.html.haml" do
  
  it "displays a new poll form" do
    render
    expect(rendered).to have_selector("form#new_poll")
  end
end
