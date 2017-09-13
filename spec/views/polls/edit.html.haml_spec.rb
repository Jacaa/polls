require 'rails_helper'

RSpec.describe "polls/edit.html.haml" do
  
  it "displays inputs as radio buttons" do
    poll = FactoryGirl.create(:poll)
    assign(:poll, poll)
    render
    expect(rendered).to have_selector("form#edit_poll_#{poll.id}")
    poll.answers.each do |answer|
      expect(rendered).to have_selector("input[type='radio']")
      expect(rendered).to have_selector("input[value='#{answer}']")
    end
  end

  it "displays inputs as checkboxes" do
    poll = FactoryGirl.create(:poll_allow_multiple)
    assign(:poll, poll)
    render
    expect(rendered).to have_selector("form#edit_poll_#{poll.id}")
    poll.answers.each do |answer|
      expect(rendered).to have_selector("input[type='checkbox']")
      expect(rendered).to have_selector("input[value='#{answer}']")
    end
  end
end
