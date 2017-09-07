require 'rails_helper'

RSpec.describe "polls/edit.html.haml" do
  
  it "displays the poll edit form - voting" do
    poll = Poll.create(question: "What's your favourite color?",
                       answers: [ "Blue", "Green", "Yellow"])
    assign(:poll, poll)
    render
    expect(rendered).to have_selector("form#edit_poll_#{poll.id}")
    poll.answers.each do |answer|
      expect(rendered).to have_selector("input[value='#{answer}']")
    end
  end
end
