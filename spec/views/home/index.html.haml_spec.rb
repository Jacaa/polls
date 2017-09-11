require 'rails_helper'

RSpec.describe "home/index.html.haml" do
  
  it "displays a new poll form" do
    assign(:poll, Poll.new(answers: ['','']))
    render
    expect(rendered).to have_selector("form#new_poll")
    expect(rendered).to have_selector("input[name='poll[question]']")
    expect(rendered).to have_selector("input[name='poll[answers][]']", count: 2)
    expect(rendered).to have_selector("input[name='poll[allow_multiple]']")
  end
end
