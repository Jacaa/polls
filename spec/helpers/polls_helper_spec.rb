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
end
