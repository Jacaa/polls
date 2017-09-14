require 'rails_helper'

RSpec.describe PollsHelper do

  describe "normalize" do

    context "allow multiple - false" do
      it "create an array of choosen answer" do
        answer = "blue"
        expect(normalize(answer)).to eq(["blue"])
        answer = "blue and green"
        expect(normalize(answer)).to eq(["blue and green"])
      end
    end

    context "allow multiple - true" do
      it "delete empty element" do
        answers = ["", "blue", "green"]
        expect(normalize(answers)).to eq(["blue", "green"])
      end
    end
  end

  describe "all votes for" do
    
    it "returns total number of poll's votes" do
      poll = FactoryGirl.create(:poll)
      poll.answers_with_values = {"blue": 3, "green": 2}
      expect(all_votes_for(poll)).to eq(5)
    end
  end

  describe "percentages" do
    it "returns the percent of every answer in the total number of votes" do
      poll = FactoryGirl.create(:poll)
      poll.answers_with_values = {"blue": 0, "green": 0}
      percentages = count_percentages(poll)
      expect(percentages["blue"]).to eq('0%')
      expect(percentages["green"]).to eq('0%')
      poll.answers_with_values = {"blue": 3, "green": 2}
      percentages = count_percentages(poll)
      expect(percentages["blue"]).to eq('60.0%')
      expect(percentages["green"]).to eq('40.0%')
    end
  end
end
