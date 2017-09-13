require 'rails_helper'

RSpec.describe Poll do
  
  describe "before create" do
    it "initialize answers_with_values column" do
      @poll = FactoryGirl.create(:poll)
      @poll.answers.each do |answer|
        expect(@poll.answers_with_values[answer]).to eq(0)
      end
    end
  end
  
  describe "validation" do

    before(:each) do
      @poll = FactoryGirl.build(:poll)
    end

    it "is valid with valid attributes" do
      expect(@poll).to be_valid
    end

    it "is valid with more than two possible answers" do
      @poll.answers << "blue" << "black"
      expect(@poll).to be_valid
    end 
    
    it "is valid with two non empty answers and one or more empty" do
      @poll.answers << "" << ""
      expect(@poll).to be_valid
    end

    it "is not valid without a question" do
      @poll.question = ""
      expect(@poll).to_not be_valid
    end
    
    it "is not valid with question longer than 255" do
      @poll.question = "a" * 256
      expect(@poll).to_not be_valid
    end

    it "is not valid with no answers" do
      @poll.answers = []
      expect(@poll).to_not be_valid
    end

    it "is not valid if has less than two possible answers" do
      @poll.answers = [ "blue" ]
      expect(@poll).to_not be_valid
    end

    it "is not valid with empty answers" do
      @poll.answers = ['','']
      expect(@poll).to_not be_valid
    end

    it "is not valid with blank answers" do
      @poll.answers = ['   ','   ']
      expect(@poll).to_not be_valid
    end

    it "is not valid if has one non empty answer and one empty answer" do
      @poll.answers = [ "blue", ""]
      expect(@poll).to_not be_valid
    end

    it "is not valid if one of the answers is longer than 255" do
      @poll.answers = [ "a"*256, "b"]
      expect(@poll).to_not be_valid
    end

    it "is not valid if has only two answers and they are equal" do
      @poll.answers = [ "blue", "blue" ]
      expect(@poll).to_not be_valid
    end
  end

  describe "sort answers by values" do
    it "returns answers with values sorted DESC" do
      poll = FactoryGirl.create(:poll)
      poll.answers_with_values = {"blue": 1, "green": 5, "yellow": 3}
      poll.sort_answers_by_values
      expect(poll.answers_with_values.keys.first).to eq("green")
      expect(poll.answers_with_values.keys.last).to eq("blue")
    end
  end
end
