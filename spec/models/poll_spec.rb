require 'rails_helper'

RSpec.describe Poll do
  
  before(:each) do
    @poll = FactoryGirl.build(:poll)
  end

  it "is valid with valid attributes" do
    expect(@poll).to be_valid
  end

  it "is valid with more than two possible answers" do
    @poll.answers << "yellow" << "black"
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
end
