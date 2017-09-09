require 'rails_helper'

RSpec.describe "polls/show.html.haml" do
  
  it "results page" do
    poll = FactoryGirl.create(:poll_with_results)
    assign(:poll, poll)
    render
    poll.answers_with_values do |answer, value|
      expect(rendered).to contain(answer)
      expect(rendered).to contain(value)
    end
  end
end
