require 'rails_helper'

RSpec.describe "polls/show.html.haml" do
  
  it "displays answers with values, percentages and total number of votes" do
    poll = FactoryGirl.create(:poll)
    percentages = { "blue": 60, "green": 40 }
    poll.answers_with_values = { "blue": 3, "green": 2}
    total = 5
    assign(:percentages, percentages)
    assign(:total_votes, total)
    assign(:poll, poll)
    render
    poll.answers_with_values do |answer, value|
      expect(rendered).to contain(answer)
      expect(rendered).to contain(value)
      expect(rendered).to contain(percentages[answer])
    end
    expect(rendered).to match(/total/)
  end
end
